//
//  EffectSpeedPickerView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/12/25.
//

import SwiftUI

#if os(iOS)


struct EffectSpeedPickerView: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    let min: Float = 0
    let max: Float = 90
    let step: Float = 30
    @State var speed: Float = 0
    
    let speedFont: Font = .headline
    let speedTint: Color = .green
    
    var body: some View {
        
        if prismSessionManager.currentLightEffect != .colorclock_m && prismSessionManager.currentLightEffect != .tempclock_m && prismSessionManager.currentLightEffect != .dualmode_m && prismSessionManager.currentLightEffect != .custom_m {
            
            if (speed == 0){
                Text("FAST")
                    .foregroundStyle(speedTint)
                    .font(speedFont)
                    .bold()
            }
            
            else if (speed <= 30){
                Text("MEDIUM")
                    .foregroundStyle(speedTint)
                    .font(speedFont)
                    .bold()
            }
            
            else if speed <= 60 {
                Text("SLOW")
                    .foregroundStyle(speedTint)
                    .font(speedFont)
                    .bold()
            }
            
            else {
                Text("SLOWW")
                    .foregroundStyle(speedTint)
                    .font(speedFont)
                    .bold()
            }
        }
        
        
        
        if prismSessionManager.currentLightEffect == .rainbowmode_m {

            Slider(value: $prismSessionManager.SpecFS, in: min ... max, step: step)
                .onChange(of: prismSessionManager.SpecFS) { oldValue, newValue in
                    speed = newValue
                    lightImpact.impactOccurred()
                    prismSessionManager.sendCommand(command: .rainbowmode_m)
                }.onAppear(){
                    speed = prismSessionManager.SpecFS
                }
            
                .padding()
            
        }
        
        else if prismSessionManager.currentLightEffect == .headless_m {
            Slider(value: $prismSessionManager.HeadFS, in: min ... max, step: step)
                .onChange(of: prismSessionManager.HeadFS) { oldValue, newValue in
                    speed = newValue
                    lightImpact.impactOccurred()
                    prismSessionManager.sendCommand(command: .headless_m)
                }.onAppear(){
                    speed = prismSessionManager.HeadFS
                }
                .padding()
            
        }
        
        else if prismSessionManager.currentLightEffect == .meteorshower_m {
            
            Slider(value: $prismSessionManager.SCFS, in: min ... max, step: step)
                .onChange(of: prismSessionManager.SCFS) { oldValue, newValue in
                    speed = newValue
                    lightImpact.impactOccurred()
                    prismSessionManager.sendCommand(command: .meteorshower_m)
                }.onAppear(){
                    speed = prismSessionManager.SCFS
                }
                .padding()
            
        }
        
        else if prismSessionManager.currentLightEffect == .firemode_m {
            
            Slider(value: $prismSessionManager.FireFS, in: min ... max, step: step)
                .onChange(of: prismSessionManager.FireFS) { oldValue, newValue in
                    speed = newValue
                    lightImpact.impactOccurred()
                    prismSessionManager.sendCommand(command: .firemode_m)
                }.onAppear(){
                    speed = prismSessionManager.FireFS
                }
                .padding()
            
        }
       
    }
}

#Preview {
    EffectSpeedPickerView()
}
#endif
