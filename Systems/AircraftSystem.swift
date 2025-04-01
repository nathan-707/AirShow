//
//  AircraftSystem.swift
//  AirShow
//
//  Created by Nathan Eriksen on 3/23/24.
//

import Foundation
import RealityKit


class AircraftComponent: Component {
    
    var currentSpeed: SIMD3<Float>
    
    var properties: Aircraft
    
    var ignore = false
    
    var showType: ShowType
    
    var playedPassOverSound = false
    
    init(properties: Aircraft, ignore: Bool = false, showType: ShowType, playedPassOverSound: Bool = false, currentSpeed: SIMD3<Float> = [0,0,0]) {
        self.properties = properties
        self.ignore = ignore
        self.showType = showType
        self.playedPassOverSound = playedPassOverSound
        self.currentSpeed = currentSpeed
    }
}


struct AirshowSystem: System {
    
    static let query = EntityQuery(where: .has(AircraftComponent.self))
    
    init(scene: RealityKit.Scene) {}
    
    let passOverThres: Float = -150
    let heightThres: Float = 50
    let xThresInBothLeftAndRight: Float = 200
    
    func playJetPassOverSound(jet: Entity, sound: AudioResource){
        
        jet.playAudio(sound).gain = -10 // was 15
        
        
    }
    
    func update(context: SceneUpdateContext) {
        for aircraft in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard let component: AircraftComponent = aircraft.components[AircraftComponent.self] else { continue }
            
            if (aircraft.position(relativeTo: origin_Aircraft).z <= passOverThres && aircraft.position(relativeTo: origin_Aircraft).z > (passOverThres - 5))
                &&
                (aircraft.position(relativeTo: origin_Aircraft).x < xThresInBothLeftAndRight && aircraft.position(relativeTo: origin_Aircraft).x > -xThresInBothLeftAndRight)
                &&
                ((component.properties.sound == .jetPlaneNoise) || (component.properties.animationType == .large_fast_plane))
                
            {
                
                if component.playedPassOverSound == false   {
                    
                    component.playedPassOverSound = true
                    aircraft.components.set(component)
                    playJetPassOverSound(jet: aircraft, sound: allJetOverHeadPassSounds.randomElement()!)
                }
            }
            
            
            else if (aircraft.position(relativeTo: origin_Aircraft).z <= passOverThres && aircraft.position(relativeTo: origin_Aircraft).z > (passOverThres - 5))
                        &&
                        (aircraft.position(relativeTo: origin_Aircraft).x < xThresInBothLeftAndRight && aircraft.position(relativeTo: origin_Aircraft).x > -xThresInBothLeftAndRight)
                        &&
                        (((component.properties.animationType == .agile_slow_plane)))
            {
                if component.playedPassOverSound == false   {
                    
                    component.playedPassOverSound = true
                    aircraft.components.set(component)
                    DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(350)) {
                        playJetPassOverSound(jet: aircraft, sound: allPropPassOver.randomElement()!!)
                        
                    }
                    
                }
            }
            
            if aircraft.position(relativeTo: origin_Aircraft).z > 4000 {
                aircraft.removeFromParent()
                break
            }
            
            if let plane = aircraft.children.first {
                if plane.position(relativeTo: origin_Aircraft).z > 4000 {
                    plane.parent?.removeFromParent()
                }
            }
        }
    }
}

