//
//  ParkPicker.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/4/25.
//

import SwiftUI
#if os(iOS)


let editSymbol = "slider.horizontal.2.square"

struct ParkPicker: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager

    var body: some View {
        VStack {
            if(prismSessionManager.pendingMode != .themeParkMode && !prismSessionManager.pending){
                
                Button("THEME PARK", systemImage: "wand.and.sparkles") {
                    impact.impactOccurred()
                    prismSessionManager.pending = true
                    prismSessionManager.pendingMode = .themeParkMode
                    prismSessionManager.sendCommand(command: .themeParkMode)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .tint(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                .foregroundStyle(.white)
                
                Picker("ThemeParkPicker", selection: $prismSessionManager.selectedPark, content: {
                    ForEach(AllParks) { park in
                        Text(park.pickerName()).tag(park)
                    }
                })
                .tint(prismSessionManager.prismboxVersion?.color ?? .accentColor)
                
            }
        }.padding()
    }
}

// Ensure preview works
#Preview {
    ParkPicker()
        .environmentObject(ClockSessionManager()) // Provide a mock environment object
}

#endif
