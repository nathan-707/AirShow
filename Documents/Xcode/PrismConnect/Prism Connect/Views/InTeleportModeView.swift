//
//  InTeleportModeView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/10/25.
//

import SwiftUI

struct InTeleportModeView: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    
    var body: some View {
        VStack{
            Text("Welcome to").font(.headline).bold().padding(5)
            Text(prismSessionManager.CurrentTeleportation.city + ", " + prismSessionManager.CurrentTeleportation.territory)
                .font(.title2).bold()
            
        }
    }
}

#Preview {
    InTeleportModeView()
        .environmentObject(ClockSessionManager.init())
}
