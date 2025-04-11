//
//  ClockSpace.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 4/8/25.
//


#if os(visionOS)

import SwiftUI

import RealityKit
import RealityKitContent



struct ClockSpace: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager

    
    var body: some View {
         
        let timeEntity = ModelEntity(mesh:
                                        
                .generateText( String(prismSessionManager.clock_time_hour) + ":" + String(prismSessionManager.clock_time_min), extrusionDepth: 0.1 ), materials: [UnlitMaterial(color: .green)])
        
        RealityView { content in
            
            guard let Scene = try? await Entity(named: "ClockScene", in: realityKitContentBundle) else {fatalError()}
            content.add(Scene)
            
            let clock = Scene.findEntity(named: "Transform")!
            
            timeEntity.scale = [0.01,0.01,0.01]
            
            clock.addChild(timeEntity)
            
            timeEntity.position.y += 0.1
            timeEntity.position.x += -0.15
        }

        
        Text("Hello, World!")
    }
}

#Preview {
    ClockSpace()
}


#endif
