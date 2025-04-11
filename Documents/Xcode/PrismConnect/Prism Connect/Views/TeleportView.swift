//
//  TeleportView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/5/25.
//

import SwiftUI


#if os(iOS)


struct TeleportView: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    @State private var teleSettingsShown = false
    
    var body: some View {
        VStack {
            if !prismSessionManager.pending && prismSessionManager.pendingMode != .teleportMode {
                
                Button("TELEPORT", systemImage: "globe.americas.fill") {
                    
                    
                    impact.impactOccurred()
                    prismSessionManager.pendingMode = .teleportMode
                    prismSessionManager.sendCommand(command: .teleportMode)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .tint(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                .foregroundStyle(.white)
                
                Picker("Teleport Picker", selection: $prismSessionManager.selectedTeleportCity) {
                    ForEach(ALL_CITIES) { city in
                        Text(city.nameForPicker()).tag(city)
                    }
                }
                .tint(prismSessionManager.prismboxVersion?.color ?? .accentColor)
            }
        }
    }
}

#Preview {
    TeleportView()
}
#endif
