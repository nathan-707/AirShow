//
//  sessionManager.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 2/25/25.
//

import Foundation

#if os(iOS)
import AccessorySetupKit
#endif

import CoreBluetooth
import SwiftUI

enum Views {
    case connectedMainMenu, connectedLightEffects
}


class ClockSessionManager: NSObject, ObservableObject {
    
    // MARK: - clock info
    @Published var clock_time_hour: Int = 0
    @Published var clock_time_min: Int = 0
    @Published var clock_weekDay: Int = 0
    @Published var clock_DOM: Int = 0
    @Published var clock_month: Int = 0
    
    
    
    // MARK: - Settings
    @Published var currentMode: Modes = .home
    @Published var currentLightEffect: LightEffects = .custom_m
    @Published var currentLayout = 1
    @Published var pending: Bool = false
    @Published var masterEffect: MasterEffect = .showW
    @Published var nutz: Int = 3
    
    // Effect speed settings.
    @Published var customRed: Int = 255
    @Published var customGreen: Int = 255
    @Published var customBlue: Int = 255
    
    @Published var tempRed: Int = 0
    @Published var tempGreen: Int = 0
    @Published var tempBlue: Int = 0
    
    @Published var selectedPark: ThemePark = AllParks[0]
    @Published var CurrentParkClockIsIn: ThemePark = AllParks[0]
    @Published var selectedTeleportCity: City = worldTourCity
    @Published var CurrentTeleportation: City = worldTourCity
    @Published var tourInterval: Int = 0
    
    @Published var onTime: Int = 1
    @Published var offTime: Int = 1
    @Published var autoOff: Bool = false
    @Published var semiAutoTurnOff: Bool = false
    
    @Published var brightness: Float = 1
    @Published var autoBrightnessOn: Bool = false
    @Published var sleepTimer: Int = 0
    
    @Published var SpecFS: Float = 3
    @Published var HeadFS: Float = 3
    @Published var SCFS: Float = 3
    @Published var FireFS: Float = 3
    
    @Published var muted: Int = 0
    @Published var sleepTimerOn: Bool = false
    
    @Published var tempClockColor: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    
    
    @Published var clock_weather = 0
    
    func syncState(update: ClockInfo){
        print("synced clock info")
        
        CurrentTeleportation = returnCityFromID(ID: update.city )
        CurrentParkClockIsIn = matchParkIDtoPark(ID: update.park)
        currentMode = Modes(rawValue: update.mode) ?? .home
        
        clock_time_min = update.timeMin
        clock_time_hour = update.timeHour
        
        clock_weekDay = update.weekDay
        clock_DOM = update.DOM
        clock_month = update.month
        
        clock_weather = update.weather
        
        
        print(clock_time_min)
        print(clock_time_hour)
    
    }
    
    
    
    
    
    func syncState(update: ClockSettings){
        
        
        currentLayout = update.layout
        currentMode = Modes(rawValue: update.mode) ?? .home
        pending = (update.pending != 0)
        muted = update.muted
        
        masterEffect = MasterEffect(rawValue: update.masterEffect) ?? .showW
        SpecFS = update.SpecFS
        HeadFS = update.HeadFS
        SCFS = update.SCFS
        FireFS = update.FireFS
        
        customRed = update.cR
        customGreen = update.cG
        customBlue = update.cB
        
        if (update.pending.true ){
            tempClockColor = CGColor(red: CGFloat(update.tempR)/255, green: CGFloat(update.tempG)/255, blue: CGFloat(update.tempB)/255, alpha: 0.0)
        } else {
            tempClockColor = CGColor(red: CGFloat(update.tempR)/255, green: CGFloat(update.tempG)/255, blue: CGFloat(update.tempB)/255, alpha: 1)
        }
        
        CurrentParkClockIsIn = matchParkIDtoPark(ID: update.park)
        tourInterval = update.telIn
        CurrentTeleportation = returnCityFromID(ID: update.city )
        onTime = update.onT
        offTime = update.offT
        autoOff = (update.autoOff != 0)
        semiAutoTurnOff = (update.semi != 0)
        brightness = update.br
        autoBrightnessOn = (update.aBr != 0)
        sleepTimer = update.sTi
        sleepTimerOn = (update.sTon != 0)
        
        if pending == false {
            pendingMode = Modes(rawValue: update.mode) ?? .home
        }
    }
    
    
    
    
    @Published var appView: Views = .connectedMainMenu
    @Published var prismboxVersion: PrismBox?
    @Published var peripheralConnected = false
    @Published var pickerDismissed = true
    @Published var authenticated = true
    @Published var pendingMode: Modes = .home
    
    
    private var manager: CBCentralManager?
    private var peripheral: CBPeripheral?
    private var clockSettingsCharacteristic: CBCharacteristic?
    
    private var vCharacteristic: CBCharacteristic?
    
    
    
    // The BLE characteristic UUID used for updating the clock
    
    
    private static let vCharacteristic_UUID = "beb4538e-36e1-4688-b7f5-ea07361b26a8"
    private static let clockUpdateCharacteristicUUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8"
    
    private static let SERVICE_UUID = "E56A082E-C49B-47CA-A2AB-389127B8ABE3"
    
    
    
    
#if os(iOS)
    private var currentDice: ASAccessory?
    private var session = ASAccessorySession()
    
    // MARK: - Accessory Picker Items
    private static let mono: ASPickerDisplayItem = {
        let descriptor = ASDiscoveryDescriptor()
        descriptor.bluetoothServiceUUID = PrismBox.mono.serviceUUID
        
        return ASPickerDisplayItem(
            name: PrismBox.mono.displayName,
            productImage: UIImage(named: PrismBox.mono.productImageName)!,
            descriptor: descriptor
        )
    }()
    
    private static let stereo: ASPickerDisplayItem = {
        let descriptor = ASDiscoveryDescriptor()
        descriptor.bluetoothServiceUUID = PrismBox.Accessory.serviceUUID
        return ASPickerDisplayItem(
            name: PrismBox.Accessory.displayName,
            productImage: UIImage(named: PrismBox.Accessory.productImageName)!,
            descriptor: descriptor
        )
    }()
#endif
    
    // MARK: - Initialization
    override init() {
        super.init()
        
        
#if os(visionOS)
        
        if manager == nil {
            manager = CBCentralManager(delegate: self, queue: nil)
        }
#endif
        
        
        // Activate the accessory session on the main queue.
#if os(iOS)
        self.session.activate(on: DispatchQueue.main, eventHandler: handleSessionEvent(event:))
#endif
        
    }
    
    
#if os(iOS)
    // MARK: - Accessory Picker
    func presentPicker() {
        Self.stereo.setupOptions = .confirmAuthorization
        
        session.showPicker(for: [Self.stereo, Self.mono]) { error in
            if let error = error {
                print("Failed to show picker due to: \(error.localizedDescription)")
            }
        }
    }
    
    func removePrismBox() {
        guard let currentDice = currentDice else { return }
        
        if peripheralConnected {
            disconnect()
        }
        
        session.removeAccessory(currentDice) { _ in
            self.prismboxVersion = nil
            self.currentDice = nil
            self.manager = nil
        }
    }
    
    private func savePrismBox(prismBox: ASAccessory) {
        currentDice = prismBox
        
        if manager == nil {
            manager = CBCentralManager(delegate: self, queue: nil)
        }
        
        if prismBox.displayName == PrismBox.mono.displayName {
            prismboxVersion = .mono
        } else if prismBox.displayName == PrismBox.Accessory.displayName {
            prismboxVersion = .Accessory
        }
    }
    
    
    
    private func handleSessionEvent(event: ASAccessoryEvent) {
        switch event.eventType {
        case .pickerSetupPairing:
            print("Pairing in progress...")
            authenticated = false
        case .accessoryAdded, .accessoryChanged:
            guard let prismBox = event.accessory else { return }
            savePrismBox(prismBox: prismBox)
        case .activated:
            guard let prismBox = session.accessories.first else { return }
            savePrismBox(prismBox: prismBox)
        case .pickerDidPresent:
            pickerDismissed = false
        case .pickerDidDismiss:
            pickerDismissed = true
        case .pickerSetupFailed:
            authenticated = false
            break
        case .invalidated:
            print("Session invalidated")
            authenticated = false
        default:
            print("Received event type \(event)")
        }
    }
    
    
#endif
    
    // MARK: - Connection Management
    func connect() {
        guard let manager = manager, manager.state == .poweredOn,
              let peripheral = peripheral else {
            return
        }
        
        manager.connect(peripheral)
    }
    
    func disconnect() {
        guard let peripheral = peripheral, let manager = manager else { return }
        manager.cancelPeripheralConnection(peripheral)
    }
    
    // MARK: - Accessory Session Functions
    
    
    
    func getFadeSpeedForEffect(effect: LightEffects) -> Float {
        
        switch effect {
        case.colorclock_m:
            break
        case .custom_m:
            break
        case .dualmode_m:
            break
        case .firemode_m:
            return FireFS
        case .headless_m:
            return HeadFS
        case .meteorshower_m:
            return SCFS
        case .rainbowmode_m:
            return SpecFS
        case .tempclock_m:
            break
        }
        
        return 0.0
        
    }
    
    // MARK: - BLE Communication: Update Clock
    /// send change light effect command.
    func sendCommand(command: LightEffects) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "effect"
            var value: LightEffects
            var value2: Float
        }
        
        
        
        let toESP = Command(value: command, value2: getFadeSpeedForEffect(effect: command))
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    /// send change mode command.
    func sendCommand(command: Modes) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "mode"
            var value: Modes
            var value2: Int = 0
        }
        
        var toESP = Command(value: command)
        
        if command == .teleportMode {
            toESP.value2 = self.selectedTeleportCity.id
        }
        
        else if command == .themeParkMode {
            toESP.value2 = self.selectedPark.id
        }
        
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    
    func updateSettings(nameOfSetting: String, value: Float) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command: String
            var value: Float
        }
        
        let toESP = Command(command: nameOfSetting, value: value)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    func updateSettings(nameOfSetting: String, value: Int) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command: String
            var value: Int
        }
        
        let toESP = Command(command: nameOfSetting, value: value)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    func updateSettings(nameOfSetting: String, value: String) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command: String
            var value: String
        }
        
        let toESP = Command(command: nameOfSetting, value: value)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    func updateMasterEffect() {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "showSpec"
            var value: MasterEffect
        }
        
        let toESP = Command(value: self.masterEffect)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    // manually ping the esp to get a state update.
    func ping() {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "ping"
            var value = "_"
        }
        
        let toESP = Command()
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    func updateLayout(layout: Int) {
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "layout"
            var value: Int
        }
        
        let toESP = Command(value: layout)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
    
    
    func updateCustomColor() {
        
        guard let peripheral = peripheral,
              let characteristic = clockSettingsCharacteristic,
              characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
        else {
            print("Cannot write: Peripheral or characteristic unavailable, or not writable")
            return
        }
        
        struct Command: Codable {
            var command = "cset"
            var red: Int
            var green: Int
            var blue: Int
        }
        
        let toESP = Command(red: self.customRed, green: self.customGreen, blue: self.customBlue)
        peripheral.writeValue(encodeTOJSON(any: toESP), for: characteristic, type: .withResponse)
    }
}


// MARK: - CBCentralManagerDelegate

extension ClockSessionManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        print("Central manager state: \(central.state)")
        switch central.state {
        case .poweredOn:
            print("power up")
            
#if os(visionOS)
            central.scanForPeripherals(withServices: [CBUUID(string: ClockSessionManager.SERVICE_UUID)], options: nil)
#endif
            
            
#if os(iOS)
            currentDice?.descriptor.supportedOptions = [.bluetoothPairingLE]
            if let peripheralUUID = currentDice?.bluetoothIdentifier {
                print(currentDice?.bluetoothIdentifier)
                peripheral = central.retrievePeripherals(withIdentifiers: [peripheralUUID]).first
                peripheral?.delegate = self
                // Automatically connect if the peripheral is found
                if peripheral != nil {
                    self.connect()
                }
            }
#endif
            
        default:
            peripheral = nil
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        print("""
        🛰️ Discovered Peripheral:
        Name: \(peripheral.name ?? "Unknown")
        Identifier: \(peripheral.identifier)
        RSSI: \(RSSI)
        Advertisement Data: \(advertisementData)
        """)
        
#if os(visionOS)
        self.peripheral = peripheral
        self.peripheral!.delegate = self
        self.connect()
#endif
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("Connected to peripheral: \(peripheral)")
        
#if os(iOS)
        guard let prismboxVersion = prismboxVersion else { return }
        peripheral.delegate = self
        peripheral.discoverServices([prismboxVersion.serviceUUID])
#endif
#if os(visionOS)
        peripheral.discoverServices([CBUUID(string: ClockSessionManager.SERVICE_UUID)])
#endif
        peripheralConnected = true
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from peripheral: \(peripheral)")
        peripheralConnected = false
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral), error: \(error?.localizedDescription ?? "unknown error")")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        print("Disconnected from peripheral: \(peripheral), timestamp: \(timestamp), isReconnecting: \(isReconnecting), error: \(error?.localizedDescription ?? "unknown error")")
    }
    
}

// MARK: - CBPeripheralDelegate

extension ClockSessionManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil, let services = peripheral.services else {
            print("Service discovery failed: \(error?.localizedDescription ?? "unknown error")")
            return
        }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard error == nil, let characteristics = service.characteristics else { return }
        
        print(characteristics.count)
        
#if os(iOS)
        for characteristic in characteristics where characteristic.uuid == CBUUID(string: Self.clockUpdateCharacteristicUUID) {
            clockSettingsCharacteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.readValue(for: characteristic)
        }
#endif
        
        for characteristic in characteristics where characteristic.uuid == CBUUID(string: Self.vCharacteristic_UUID){
            vCharacteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
            print(peripheral.readValue(for: characteristic))
            print("read value")
        }
        
        
        
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    
    {
#if os(iOS)
        Task { // dismiss the session thing if not already.
            if let currentDice = currentDice {
                do {
                    try await session.finishAuthorization(for: currentDice, settings: .default)
                } catch {
                    print("Error finishing authorization: \(error.localizedDescription)")
                }
            }
        }
        
        
        
        
        
        if characteristic.uuid == CBUUID(string: Self.clockUpdateCharacteristicUUID){
            guard let data = characteristic.value else {
                return
            }
            
            if let stateUpdate = try? JSONDecoder().decode(ClockSettings.self, from: data){ // try to decode ClockSettings
                syncState(update: stateUpdate)
                authenticated = true
                print(stateUpdate)
                
                DispatchQueue.main.async {
                    withAnimation {
                        print("Connected – UI should update accordingly.")
                    }
                }
            } else {
                print("Decoding error.")
                print(data)
            }
        }
    
#endif
    
         if characteristic.uuid == CBUUID(string: Self.vCharacteristic_UUID){
            guard let data = characteristic.value else {
                return
            }
            
            if let stateUpdate = try? JSONDecoder().decode(ClockInfo.self, from: data){ // try to decode ClockSettings
                syncState(update: stateUpdate)
                authenticated = true
                print(stateUpdate)
                
                DispatchQueue.main.async {
                    withAnimation {
                        print("Connected – UI should update accordingly.")
                    }
                }
            } else {
                print("Decoding error.")
                print(data)
            }
            
            
        }
        
        
    }
}

func encodeTOJSON(any: Codable) -> Data {
    do {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(any)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("Writing with response: \(jsonString)")
        } else {
            print("Writing with response: command updated")
        }
        
        return jsonData
    } catch {
        print("Failed to encode command: \(error)")
    }
    
    return Data()
}


extension Int {
    var `true`: Bool {
        return self != 0
    }
    
    var `false`: Bool {
        return self == 0
    }
}
