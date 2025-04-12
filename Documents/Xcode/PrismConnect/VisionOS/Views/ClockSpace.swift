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


//
//  WeatherManager.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 4/9/25.
//




struct ClockSpace: View {
    @EnvironmentObject private var prismSessionManager: ClockSessionManager
    
    @State var weatherManager: WeatherManager?
    
    var body: some View {
        
        RealityView { content in
            
//            let ceiling = AnchorEntity(.plane(.any, classification: .ceiling, minimumBounds: [0,0,0]))
            
//            print(ceiling.visualBounds(relativeTo: nil))
            
            guard let Scene = try? await Entity(named: "ClockScene", in: realityKitContentBundle) else {fatalError()}
            
            weatherManager = WeatherManager(scene: Scene, weather: prismSessionManager.clock_weather, hour: prismSessionManager.clock_time_hour, min: prismSessionManager.clock_time_min, wholeRoom: prismSessionManager.wholeRoom)
            
            content.add(weatherManager!.clock)
            
        }.onChange(of: prismSessionManager.clock_weather) {
            weatherManager?.updateWeather(weatherUpdate: prismSessionManager.clock_weather, wholeRoom: prismSessionManager.wholeRoom)
        }
        
        .onChange(of: prismSessionManager.clock_time_min) {
            weatherManager?.updateTime(hour: String(prismSessionManager.clock_time_hour), min: String(prismSessionManager.clock_time_min))
        }
    }
}

#Preview {
    ClockSpace()
}


#endif

