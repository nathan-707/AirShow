//
//  Prism_ConnectApp.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 6/14/24.
//

import SwiftUI

@main
struct Prism_ConnectApp: App {
    @State var prismSessionManager = ClockSessionManager()
    
    
#if os(visionOS)
    var body: some Scene {
        
        WindowGroup {
            VisionView()
                .environmentObject(prismSessionManager)

        }
        
        
        ImmersiveSpace(id: "ClockSpace") {
            ClockSpace()
                .environmentObject(prismSessionManager)

        }
    }
    
 
        #endif

    
    
    
    
#if os(iOS)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(prismSessionManager)
        }
    }
#endif

    
    
}
