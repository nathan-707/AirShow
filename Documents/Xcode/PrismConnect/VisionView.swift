//
//  VisionView.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 4/7/25.
//

import SwiftUI

#if os(visionOS)



struct VisionView: View {
    
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        VStack{
            Text("Hello, vision!")
            
            Text(String (prismSessionManager.clock_time_hour) + ":" + String(prismSessionManager.clock_time_min))
            
            Button {
                
                Task {
                    await openImmersiveSpace(id: "ClockSpace")
                }

            } label: {
                Text("open space")
            }
        }
    }
}

#Preview {
    VisionView()
}
#endif
