//
//  PickEffectView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/5/25.
//

import SwiftUI

#if os(iOS)

struct PickEffectView: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    @State var selectedTile = ColorTile(red: 255, green: 0, blue: 0)
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if prismSessionManager.currentLightEffect == .custom_m {
                Picker("colorpicker", selection: $selectedTile) {
                    ForEach(ColorTiles) { tile in
                        let color = Color(red: Double(tile.red), green: Double(tile.green), blue: Double(tile.blue))
                        Rectangle().frame(width: 50,height: 50)
                            .foregroundColor(color)
                            .padding(5)
                            .tag(tile)
                    }
                }
                .pickerStyle(.wheel)
                .scaledToFit()
                .onChange(of: selectedTile) { oldValue, newValue in
                    prismSessionManager.customRed = selectedTile.redmapTo255()
                    prismSessionManager.customGreen = selectedTile.greenmapTo255()
                    prismSessionManager.customBlue = selectedTile.bluemapTo255()
                    prismSessionManager.updateCustomColor()
                }
            }
            
//            const int speed1 = 250;
//            const int speed2 = 100;
//            const int speed3 = 40;
//            const int speed4 = 20;
//            const int speed5 = 10;
//            const int speed6 = 0;
            
            
EffectSpeedPickerView()
            
            
            Picker("customOrWeather", selection: $prismSessionManager.masterEffect){
                Text("Effect Only").tag(MasterEffect.fullEff)
                Text("Both").tag(MasterEffect.showW)
                Text("Weather Only").tag(MasterEffect.onlyShowW)
            }
            .pickerStyle(.palette)
            .onChange(of: prismSessionManager.masterEffect) { oldValue, newValue in
                lightImpact.impactOccurred()
                prismSessionManager.updateMasterEffect()
            }
            .tint(.green)
            .padding()
            
            
            Picker("picklighteffect", selection: $prismSessionManager.currentLightEffect) {
                Text("Custom Color").tag(LightEffects.custom_m)
                Text("Dual").tag(LightEffects.dualmode_m)
                Text("Spectrum").tag(LightEffects.rainbowmode_m)
                Text("Headless").tag(LightEffects.headless_m)
                Text("Short Circuit").tag(LightEffects.meteorshower_m)
                Text("Color Clock").tag(LightEffects.colorclock_m)
                Text("Temp Clock").tag(LightEffects.tempclock_m)
                Text("Fire").tag(LightEffects.firemode_m)
            }
            .pickerStyle(.wheel)
            .scaledToFit()
            .onChange(of: prismSessionManager.currentLightEffect, { oldValue, newValue in
                print("sending")
                prismSessionManager.sendCommand(command: newValue)
            })
            
        }
        
    }
}

#endif
//
//#Preview {
//    PickEffectView()
//        .environmentObject(ClockSessionManager.init())
//}
