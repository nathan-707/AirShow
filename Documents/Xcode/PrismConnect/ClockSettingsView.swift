//
//  ClockSettingsView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/6/25.
//

import SwiftUI

struct ClockSettingsView: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    
    var body: some View {
        Form {
            Section(header: Text("Layout")) {
                LayoutPicker()
            }
            
            Section(header: Text("When Clock Turns On/Off")){
                Toggle("Automatic", isOn: $prismSessionManager.autoOff)
                    .onChange(of: prismSessionManager.autoOff) { oldValue, newValue in
                        
                        prismSessionManager.updateSettings(nameOfSetting: "autoOff", value: (newValue == false ? 0 : 1))
                    }
                
                if !prismSessionManager.autoOff {
                    OnTimePicker()
                    OffTimePicker()
                    Toggle("Wait Till Its Also Dark After Off Time", isOn: $prismSessionManager.semiAutoTurnOff)
                        .onChange(of: prismSessionManager.semiAutoTurnOff) { oldValue, newValue in
                            prismSessionManager.updateSettings(nameOfSetting: "semiAutoTurnOff", value: (newValue == false ? 0 : 1))
                        }
                }
            }
            
            
            Section(header: Text("Tele-Settings")){
                TourIntervalPicker()
            }
            
            Section(header: Text("Brightness")) {
                Toggle("Auto Dimming", isOn: $prismSessionManager.autoBrightnessOn)
                    .onChange(of: prismSessionManager.autoBrightnessOn) { oldValue, newValue in
                        prismSessionManager.updateSettings(nameOfSetting: "autoBrightnessOn", value: (newValue == false ? 0 : 1))
                        if !newValue {
                            prismSessionManager.brightness = 1
                        }
                    }
                
                if !prismSessionManager.autoBrightnessOn {
                    Slider(value: $prismSessionManager.brightness, in: 0 ... 1, step: 0.1)
                    
                        .onChange(of: prismSessionManager.brightness) { oldValue, newValue in
                            prismSessionManager.updateSettings(nameOfSetting: "brightness", value: newValue)
                        }
                }
            }
        }
        
    }
}

#Preview {
    ClockSettingsView()
        .environmentObject(ClockSessionManager.init())
}

struct LayoutPicker: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    var body: some View {
        Picker("Layout", selection: $prismSessionManager.currentLayout) {
            Text("1").tag(1)
            Text("2").tag(2)
            Text("3").tag(3)
            Text("4").tag(4)
            Text("5").tag(5)
            Text("6").tag(6)
            Text("7").tag(7)
            Text("8").tag(8)
            Text("9").tag(9)
            Text("10").tag(10)
            Text("11").tag(11)
            Text("12").tag(12)
        }
        .onChange(of: prismSessionManager.currentLayout) { oldValue, newValue in
            prismSessionManager.updateLayout(layout: prismSessionManager.currentLayout)
        }
        
    }
}

struct OnTimePicker: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    var body: some View {
        Picker("Clock On Time", selection: $prismSessionManager.onTime) {
            Text("1 AM").tag(1)
            Text("2 AM").tag(2)
            Text("3 AM").tag(3)
            Text("4 AM").tag(4)
            Text("5 AM").tag(5)
            Text("6 AM").tag(6)
            Text("7 AM").tag(7)
            Text("8 AM").tag(8)
            Text("9 AM").tag(9)
            Text("10 AM").tag(10)
            Text("11 AM").tag(11)
            Text("12 AM").tag(12)
            Text("1 PM").tag(13)
            Text("2 PM").tag(14)
            Text("1 PM").tag(15)
            Text("2 PM").tag(16)
            Text("3 PM").tag(17)
            Text("6 PM").tag(18)
            Text("7 PM").tag(19)
            Text("8 PM").tag(20)
            Text("9 PM").tag(21)
            Text("10 PM").tag(22)
            Text("11 PM").tag(23)
            Text("12 PM").tag(24)
        }
        .onChange(of: prismSessionManager.onTime) { oldValue, newValue in
            prismSessionManager.updateSettings(nameOfSetting: "onTime", value: newValue)
        }
        
    }
}

struct OffTimePicker: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    var body: some View {
        Picker("Clock Off Time", selection: $prismSessionManager.offTime) {
            Text("1 AM").tag(1)
            Text("2 AM").tag(2)
            Text("3 AM").tag(3)
            Text("4 AM").tag(4)
            Text("5 AM").tag(5)
            Text("6 AM").tag(6)
            Text("7 AM").tag(7)
            Text("8 AM").tag(8)
            Text("9 AM").tag(9)
            Text("10 AM").tag(10)
            Text("11 AM").tag(11)
            Text("12 AM").tag(12)
            Text("1 PM").tag(13)
            Text("2 PM").tag(14)
            Text("1 PM").tag(15)
            Text("2 PM").tag(16)
            Text("3 PM").tag(17)
            Text("6 PM").tag(18)
            Text("7 PM").tag(19)
            Text("8 PM").tag(20)
            Text("9 PM").tag(21)
            Text("10 PM").tag(22)
            Text("11 PM").tag(23)
            Text("12 PM").tag(24)
            
        }
        .onChange(of: prismSessionManager.offTime) { oldValue, newValue in
            prismSessionManager.updateSettings(nameOfSetting: "offTime", value: newValue)
        }
        
    }
}

struct TourIntervalPicker: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    
    var body: some View {
        
        Picker("World Tour Interval", selection: $prismSessionManager.tourInterval) {
            Text("1 Min").tag(60000)
            Text("3 Min").tag(60000 * 3)
            Text("5 Min").tag(60000 * 5)
            Text("10 Min").tag(60000 * 10)
            Text("1 Hr").tag(60000 * 60)
            Text("3 Hr").tag(60000 * 60 * 3)
        }
        .onChange(of: prismSessionManager.tourInterval) { oldValue, newValue in
            prismSessionManager.updateSettings(nameOfSetting: "tourInterval", value: newValue)
        }
        
    }
}
