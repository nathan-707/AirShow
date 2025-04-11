//
//  ConnectedMainMenu.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 2/28/25.
//

import SwiftUI




#if os(iOS)
let impact = UIImpactFeedbackGenerator(style: .heavy)
let notPendingImpact = UIImpactFeedbackGenerator(style: .rigid)
let lightImpact = UIImpactFeedbackGenerator(style: .light)

let testing = true

var platform: String = ""




struct ConnectedMainMenu: View {

    
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var settingsShown = false
    @State private var animate = false
    @Environment(\.colorScheme) var colorScheme // Detects light or dark mode
    
    var body: some View {
        ZStack{
            
            if prismSessionManager.currentMode == .teleportMode || prismSessionManager.currentMode == .themeParkMode {
                
                let startColor: Color = colorScheme == .dark ? .black : .white
                
                let endColor: Color = Color(cgColor: prismSessionManager.tempClockColor)
                
                LinearGradient(
                    gradient: Gradient(colors: [startColor, endColor]),
                    startPoint: .center,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
            }
            
            VStack {
                
                if prismSessionManager.peripheralConnected || testing {
                    
                    HStack {
                        
                        if prismSessionManager.sleepTimerOn && !prismSessionManager.pending{
                            Button("", systemImage: "powersleep") {
                                

                                impact.impactOccurred()
                                
                                prismSessionManager.sleepTimerOn = false
                                prismSessionManager.updateSettings(nameOfSetting: "sleepTimer", value: 0)
                            }
                        }
                        
                        Text(prismSessionManager.pendingMode.title())
                            .font(.system(size: 50).monospaced().bold())
                            .foregroundStyle(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                            .padding()
                        
                        if !prismSessionManager.pending{
                            Button("", systemImage: "gear") {
                                settingsShown = true
                            }
                            .tint(.secondary)
                        }
                    }
                    
                    if prismSessionManager.pendingMode == .home && !prismSessionManager.pending {
                        TeleportView()
                        Divider()
                    }
                    
                    if prismSessionManager.pendingMode == .home && !prismSessionManager.pending {
                        ParkPicker()
                        Divider()
                    }
                    
                    if prismSessionManager.currentMode == .home && !prismSessionManager.pending {
                        PickEffectView()
                    }
                    
                    if prismSessionManager.currentMode == .sleepMode{
                        SleepModeView()
                    }
                    
                    if !prismSessionManager.pending {
                        
                        if prismSessionManager.currentMode != .home && prismSessionManager.currentMode != .sleepMode {
                            
                            if prismSessionManager.currentMode == .teleportMode {
                                InTeleportModeView()
                            } else if prismSessionManager.currentMode == .themeParkMode {
                                ThemeParkView()
                            }
                            
                            Button(String(), systemImage: "house", action: {
                                impact.impactOccurred()
                                prismSessionManager.pending = true
                                prismSessionManager.pendingMode = .home
                                prismSessionManager.sendCommand(command: .home)
                            })
                            
                            .foregroundStyle(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                            .scaleEffect(2)
                            .padding()
                        }
                    }
                    
                    if prismSessionManager.pending {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                    if !prismSessionManager.peripheralConnected {
                        Text("Searching...")
                            .foregroundStyle(.red)
                            .controlSize(.large)
                            .buttonStyle(.borderedProminent)
                            .tint(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 64)
                            .padding(.bottom, 6)
                            .padding(.bottom, 35)
                    }
                    
                } else {
                    VStack{
                        Text("Searching...")
                            .foregroundStyle(.secondary)
                            .font(.title)
                        ProgressView()
                    }
                }
            }
            .onAppear(){
                prismSessionManager.connect()
            }
        }
        
        .sheet(isPresented: $settingsShown) {
            ClockSettingsView()
        }
        
        .onChange(of: prismSessionManager.pending, { oldValue, newValue in
            if !newValue{
                notPendingImpact.impactOccurred()
            }
        })
        
        .onAppear(){
            impact.prepare()
            notPendingImpact.prepare()
            lightImpact.prepare()
        }
        
        .onChange(of: prismSessionManager.peripheralConnected, { oldValue, newValue in
            if (newValue == false){
                prismSessionManager.pendingMode = .home
                prismSessionManager.pending = false
            }
        })
        
        .onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                prismSessionManager.ping()
            }
        })
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(timer) { _ in
            
            if  !prismSessionManager.peripheralConnected{ // auto reconnect eveery 1 second.
                prismSessionManager.connect()
            }
        }
    }
}

#Preview {
    ConnectedMainMenu()
        .environmentObject(ClockSessionManager.init())
}
#endif
