//
//  AirShow.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/8/24.
//

import Foundation
import RealityKit
import SwiftUI
import Combine


let slowBoost: Float = -0.5
let realisticBoost: Float = 0
let fastBoost: Float = 1.2


enum Boost {
    case slow, normal, fast
    
    func returnBoost(animationType: animationType) -> Float {
        
        var speed: Float = 0
        switch self {
        case .slow:
            speed = slowBoost
        case .normal:
            speed = realisticBoost
        case .fast:
            speed = fastBoost
        }
        
        switch animationType {
            
        case .agile_fast_plane:
            
            //            return speed - 1.0
            
            if self != .fast {
                return speed - 0.5
            }
            else {
                return fastBoost * 0.5 // if its on the fast setting, only speed it up a little for the jets
            }
            
        case .agile_slow_plane:
            return speed
            
        case .large_fast_plane:
            return speed
            
        case .large_slow_plane: // large slow planes dont need to be slower so only slow them down a little for the large planes.
            if self != .slow {
                return speed
            } else {
                return slowBoost * 0.5
            }
            
        case .helicoper:
            return speed
        }
    }
}

let calibrating = false // set to true to adjust aircrafts offsets.
let distanceToDelete: Float = 2200 // meters to delete planes once they go too far after the pass.
var currentTime = Date()
var lastSecondCount = Date()


class theAirShowModel: ObservableObject {
    @Published var numberOfPlanesOnOrigin = 0
    
    var dispatchToken: DispatchWorkItem?
    
    @Published var nowShowing = aircraftPlaceHolder
    @Published var showOver = false
    @Published var classicShow_automatic = true
    @Published var showType: ShowType = .classic
    @Published var classicShowSpeedBoost: Boost = .normal
    
    var chaoticShow = false
    var soundDelay = true
    var classicShowIndex = 0
    
    
    func customShowFrameUpdate(){
        
        currentTime = Date()
        
        if currentTime.timeIntervalSince(lastSecondCount)  > secondsInBetweenSpawn {
            lastSecondCount = currentTime
            if origin_Aircraft.children.count < maxNumberOfAircraftAtOneTimeInChaotic && self.showOver == false  {
                if let nextToSpawn = self.planesInCustomAirshow.randomElement(){
                    self.custom_spawnPlaneWithAnimation(aircraft: nextToSpawn)
                }
            }
        }
    }
    
    
    func custom_spawnPlaneWithAnimation(aircraft: Aircraft, customAnimation: CustomAnimation = CustomAnimation(animationEntity: placeHolderEntity, speed: 0.0, typeOfAnimation: .all)){
        
        var formation = true
        
        var customAnimation = customAnimation // capture there customAnimation parameter.
        
        if customAnimation.animationEntity == placeHolderEntity { // get random animation based on what sound the aircraft has, only if a specific animation is not given in the call.
            
            switch aircraft.animationType {
            case .agile_fast_plane:
                customAnimation = agile_plane_animations.randomElement()!
                customAnimation.speed += classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = false // if its a agile animation, do not do formation.
            case .agile_slow_plane:
                customAnimation = agile_plane_animations.randomElement()!
                customAnimation.speed = slowDownAgileAnimationPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = false // if its a agile animation, do not do formation.
            case .large_fast_plane:
                customAnimation = large_plane_animations.randomElement()!
                customAnimation.speed = (slowDownLargeAnimationPercent(input: customAnimation.speed) * 1.5)  + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)  // 50 percent faster from slow large plane.
                formation = decideFormationOrNot()
            case .large_slow_plane:
                customAnimation = large_plane_animations.randomElement()!
                customAnimation.speed = slowDownLargeAnimationPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = decideFormationOrNot()
            case .helicoper:
                customAnimation = helicopter_animations.randomElement()!
                customAnimation.speed = slowDownHelicopterPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = decideFormationOrNot()
            }
            
            if aircraft.animationType == .agile_fast_plane || aircraft.animationType == .agile_slow_plane {
                formation = decideFormationOrNot()
                
                if formation {
                    customAnimation = animationsThatWorkForAnyAircraft.randomElement()!
                    
                    if aircraft.animationType == .agile_fast_plane {
                        
                        customAnimation.speed += customAnimation.speed + 0.3
                        
                    }
                    customAnimation.speed = slowDownAgileAnimationPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                }
            }
        }
        
        else { // here if its the classic airshow type
            customAnimation = animationsThatWorkForAnyAircraft.randomElement()!
            
            switch aircraft.animationType {
            case .agile_fast_plane:
                customAnimation.speed += classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = classicDecideFormationOrNot()
            case .agile_slow_plane:
                customAnimation.speed = slowDownAgileAnimationPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = classicDecideFormationOrNot()
            case .large_fast_plane:
                customAnimation.speed = slowDownLargeAnimationPercent(input: customAnimation.speed) * 1.5 + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType) // 50 percent faster from slow large plane.
                formation = classicDecideFormationOrNot()
            case .large_slow_plane:
                customAnimation.speed = slowDownLargeAnimationPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = classicDecideFormationOrNot()
            case .helicoper:
                customAnimation.speed = slowDownHelicopterPercent(input: customAnimation.speed) + classicShowSpeedBoost.returnBoost(animationType: aircraft.animationType)
                formation = classicDecideFormationOrNot()
            }
        }
        
        print(customAnimation.animationEntity.name, " - ", aircraft.name, " - ", aircraft.animationType, " - origin children count: ", origin_Aircraft.children.count)
        
        
        var randomY: Float = 0
        var randomX: Float = 0
        
        if self.showType == .chaos {
            randomY = Float.random(in: 0 ... 30)
            randomX = Float.random(in: -50 ... 50)
        }
        
        var scootZ: Float = 0
        var scoot = true
        
        for _ in 0 ... 2 {
            
            let animationRoot = customAnimation.animationEntity.clone(recursive: true)
            
            animationRoot.position.x = randomX
            animationRoot.position.y = aircraft.offSet.y + randomY
            
            if aircraft.animationType == .large_slow_plane || aircraft.animationType == .large_fast_plane {
                animationRoot.position.y += 10 // if the plane is large, make it fly slightly higher than others.
            }
            
            if aircraft == xb70 {
                animationRoot.position.y += 20 // raise that big ass plane more.
            }
            
            animationRoot.position.z = scootZ
            
            let aircraftModel = aircraft.mEntity.clone(recursive: true)
            
            if let aircraftAnchorInAnimation = animationRoot.findEntity(named: "group"){
                
                aircraftAnchorInAnimation.addChild(aircraftModel)
                
                aircraftAnchorInAnimation.playAnimation(aircraftAnchorInAnimation.availableAnimations.first!, transitionDuration: 0, startsPaused: false).speed = customAnimation.speed
                
                setupAircraft(aircraft: aircraftModel, aircraftProperties: aircraft, addEmitter: true, setupForMayaAnimation: true)
                
                origin_Aircraft.addChild(animationRoot)
                
            } else {
                print("failed to find group.")
                print("GO ADD ANIMATION TO THE LOAD FUNCTION!!")
            }
            
            if formation == false {
                break
            }
            
            var xIncrement: Float = 30
            var zIncrement: Float = 50
            
            if (aircraft.animationType == .large_fast_plane || aircraft.animationType == .large_slow_plane){
                xIncrement = 55
                zIncrement = 75
            }
            
            randomX += xIncrement
            
            if scoot == true {
                
                scootZ += zIncrement
                scoot = false
            }
            else {
                scootZ -= zIncrement
            }
        }
    }
    
    
    func classicSpawnNextPlane(){
        
        self.chaoticShow = false
        
        if self.classicShowIndex > planesInCustomAirshow.count - 1 {
            print("SHOW OVER")
            self.showOver = true
            
        } else {
            custom_spawnPlaneWithAnimation(aircraft: planesInCustomAirshow[self.classicShowIndex], customAnimation: animationsThatWorkForAnyAircraft.randomElement()!)
            nowShowing = planesInCustomAirshow[self.classicShowIndex]
        }
        self.classicShowIndex += 1
    }
    
    func startClassicAirshow(){
        
        origin_Aircraft.children.removeAll()
        self.classicShow_automatic = true
        self.showOver = false
        self.planesInCustomAirshow.shuffle()
        self.classicShowIndex = 0
        self.nowShowing = planesInCustomAirshow.first!
        self.classicSpawnNextPlane()
    }
    
    func custom_startChaoticAirshow(){
        
        self.chaoticShow = true
        origin_Aircraft.children.removeAll()
        self.showOver = false
        
    }
    
    func custom_animationEnded(aircraftController: AnimationPlaybackController){
        
        aircraftController.entity?.components.set(PhysicsBodyComponent(massProperties: .default, material: .default, mode: .kinematic))
        aircraftController.entity?.components.set(PhysicsMotionComponent(linearVelocity: [0,150,0]))
        aircraftController.entity?.parent?.removeFromParent()
    }
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// VIEW PLANE FUNCS AND VARS
    
    @Published var aircraftSelected: Aircraft = F35_Lightning2
    @Published var speed: Float = 250
    @Published var height: Float = 60
    @Published var formation: Int = 1
    @Published var planesInCustomAirshow = [Aircraft]()
    
    
    func spawnPlane(position: SIMD3<Float>, addEmitter: Bool) {
        let planeToSpawn = selectedAircraftModel.clone(recursive: true)
        planeToSpawn.position = position
        setupAircraft(aircraft: planeToSpawn, aircraftProperties: aircraftSelected, addEmitter: addEmitter)
        origin_Aircraft.addChild(planeToSpawn)
    }
    
    func spawnPlaneFormation() {
        
        var numberOfPlanes = 0
        
        switch self.formation {
        case 1: // single
            numberOfPlanes = 1
        case 2: // trio
            numberOfPlanes = 2
        case 3: // large
            numberOfPlanes = 3
        default:
            numberOfPlanes = 1
        }
        
        var spacexIncrement: Float = 50
        var zBoost: Float = 0
        
        
        // add all large planes here so that they dont look stupid in a formation.
        if self.aircraftSelected == TU160 || self.aircraftSelected == stealthBomber || self.aircraftSelected == B_52 || self.aircraftSelected == b1Lancer || self.aircraftSelected == globalHawk || self.aircraftSelected == Y20 || self.aircraftSelected == ac130 || self.aircraftSelected == Osprey || self.aircraftSelected == blackBird || aircraftSelected == xb70 || self.aircraftSelected == C20A || self.aircraftSelected == DC8 || self.aircraftSelected == ER2 || self.aircraftSelected == P3 || self.aircraftSelected == OTTER || self.aircraftSelected == WB57 || self.aircraftSelected == G5
        {
            spacexIncrement = 160
            zBoost = 75
        }
        
        let spacezIncrement: Float = 50 * sqrt(3) / 2  // Adjusted for equilateral triangle
        
        let spacex: Float = 0
        
        print(numberOfPlanes)
        
        startingDistance = adjustStartingDistance(topSpeed: aircraftSelected.topSpeed, height: height)
        
        for row in 0..<numberOfPlanes {
            for column in 0...row {
                
                let xOffset = spacexIncrement * Float(column) - spacexIncrement * Float(row) / 2
                
                let zOffset = (spacezIncrement + zBoost) * Float(row)
                
                let position = SIMD3<Float>(spacex + xOffset, self.height, startingDistance - zOffset)
                spawnPlane(position: position, addEmitter: false)
            }
        }
    }
    
    func setupAircraft(aircraft: Entity, aircraftProperties: Aircraft, addEmitter: Bool = true, setupForMayaAnimation: Bool = false) {
        
        if setupForMayaAnimation == false {
            aircraft.components.set(PhysicsBodyComponent(massProperties: .default, material: .default, mode: .kinematic))
            aircraft.components.set(CollisionComponent(shapes: [.generateBox(size: [0.5,0.5,0.5])], isStatic: false))
            aircraft.components.set(PhysicsMotionComponent())
        }
     
        
        
        aircraft.components.set(SpatialAudioComponent())
        aircraft.components.set(AircraftComponent(properties: aircraftProperties, showType: self.showType))
        
        let thermalState = ProcessInfo.processInfo.thermalState
        
        if thermalState == .critical || thermalState == .serious {
            print("Device is hot.", thermalState)
        } else {
            if addEmitter && thermalState == .nominal {
                addEmitterToAircraft(emitter: aircraftProperties.emitter)
            }
            
            else if addEmitter && thermalState == .fair {
                addEmitterToAircraft(emitter: aircraftProperties.emitter, low: true)
            }
        }
        
        if let aircraftLandingGear = findChildNamed("landingGear", in: aircraft)  {
            aircraftLandingGear.removeFromParent()
        }
        
        // access animations here.
        if aircraft.availableAnimations.isEmpty == false && aircraftProperties != YE_8 { // dont t
            print("this has a animation")
            let resource = aircraft.availableAnimations.first
            let correctedResource = resource?.repeat(duration: 1000000)
            
            if aircraftProperties == UH_60 { // custom speed for UH60
                aircraft.playAnimation(correctedResource!, transitionDuration: 0, startsPaused: false).speed = 8
            } else if aircraftProperties == Osprey { // custom speed for osprey animation
                aircraft.playAnimation(correctedResource!, transitionDuration: 0, startsPaused: false).speed = 8
            }
            else {
                aircraft.playAnimation(correctedResource!, transitionDuration: 0, startsPaused: false).speed = 15
            }
        }
        
        addSoundEmitter(sound: aircraftProperties.sound, aircraft: aircraft)
        
        func addSoundEmitter(sound: sound, aircraft: Entity) {
            
            
            let audioSource = Entity()
            
            let sound = planesSoundEffect(sound: aircraftProperties.sound)
            
            if aircraftProperties.animationType == .agile_fast_plane{
                audioSource.components.set(SpatialAudioComponent(gain: .zero, directLevel: .zero, reverbLevel: spatialPlaneEngineReverb,
                                                                 
//                                                                 directivity: .beam(focus: 0.75)
                                                                
                                                                ))
//                audioSource.orientation = .init(angle: .pi, axis: [0, 1, 0]
//                
//                )
                
                
            } else {
                audioSource.components.set(SpatialAudioComponent(gain: .zero, directLevel: .zero, reverbLevel: spatialPlaneEngineReverb))
            }
            
            aircraft.addChild(audioSource)
            
            var controller2: AudioPlaybackController?
            
            if aircraftProperties.sound == .largePropellerPlaneNoise {
                let audioSource2 = Entity()
                audioSource2.components.set(SpatialAudioComponent(gain: .zero, directLevel: .zero, reverbLevel: spatialPlaneEngineReverb))
                aircraft.addChild(audioSource2)
                controller2  = audioSource2.prepareAudio(planesSoundEffect(sound: .largePlaneNoise))
            }
            
            let thisPlanesController = audioSource.prepareAudio(sound)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                thisPlanesController.play()
                controller2?.play()
                
            }
        }
        
        func addEmitterToAircraft(emitter: emitter, low: Bool = false){
            
            var emitterToAdd = Entity()
            
            emitterToAdd = graySmoke.clone(recursive: true)
            
            
            let emitterDisplacement: Float = -15
            
            switch emitter {
            case .smoke:
                aircraft.addChild(emitterToAdd)
                emitterToAdd.position = [0,0,emitterDisplacement]
            case .blue:
                //                aircraft.addChild(blueSmoke.clone(recursive: true))
                aircraft.addChild(emitterToAdd)
                emitterToAdd.position = [0,0,emitterDisplacement]
            case .green:
                //                aircraft.addChild(greenSmoke.clone(recursive: true))
                aircraft.addChild(emitterToAdd)
                emitterToAdd.position = [0,0,emitterDisplacement]
            case .none:
                break
            case .orangeJet:
                break
            case .blueJet:
                break
            }
        }
        
        func planesSoundEffect(sound: sound) -> AudioResource {
            let soundHandler = aircraftSoundEffectHandler()
            switch sound {
            case .jetPlaneNoise:
                return soundHandler.randomJetPlaneNoise()
            case .propellerPlaneNoise:
                return soundHandler.randomPropellerNoise()
            case .largePlaneNoise:
                return soundHandler.randomLargePlaneNoise()
            case .helicopterNoise:
                return soundHandler.randomHelicopterNoise()
            case .largePropellerPlaneNoise:
                return soundHandler.randomPropellerNoise()
            }
        }
    }
    
    
    func frameUpdate(){
        
        for child in origin_Aircraft.children {
            
            guard let aircraftComponent = child.components[AircraftComponent.self] else {continue}
            
            if aircraftComponent.currentSpeed.z != self.speed {
                
                aircraftComponent.currentSpeed.z = self.speed
                
                child.components.set(aircraftComponent)
                
                child.components.set(PhysicsMotionComponent(linearVelocity: SIMD3<Float>(0,0, self.speed)))
                
            }
            
            
            if child.position.z < -4000 || child.position.z > distanceToDelete {
                child.removeFromParent()
            }
        }
    }
    
    
//    func makeAnimation(startingPosition: SIMD3<Float>){
//        
//        let planeToAnimate = selectedAircraftModel.clone(recursive: true)
//        let transform = startingPosition
//        let transform2 = startingPosition + 1
//        let animationDefinition1 = FromToByAnimation(to: transform, duration: 1.0, bindTarget: .transform)
//        let animationDefinition2 = FromToByAnimation(to: transform2, duration: 1.0, bindTarget: .transform)
//        
//        // Create a Blend Tree Animation by blending the two animations
//        let blendTreeDefinition = BlendTreeAnimation<Transform>(
//            BlendTreeBlendNode(sources: [
//                BlendTreeSourceNode(source: animationDefinition1, weight: .value(0.75)),
//                BlendTreeSourceNode(source: animationDefinition2, weight: .value(0.25))
//            ])
//        )
//        
//        let animationViewDefinition = AnimationView(source: blendTreeDefinition, delay: 5, speed: 0.5)
//        let animationResource = try! AnimationResource.generate(with: animationViewDefinition)
//        planeToAnimate.playAnimation(animationResource)
//    }
    
    func deinitShow(){
        self.chaoticShow = false
        
        self.showOver = true
        origin_Aircraft = Entity()
    }
}

func classicDecideFormationOrNot() -> Bool {
    let decision = Int.random(in: 2...3)
    if decision == 3 {
        return true
    } else {
        return false
    }
}
func decideFormationOrNot() -> Bool {
    let decision = Int.random(in: 1...8)
    if decision == 3{
        return true
    } else {
        return false
    }
}



var planeAudioControllers: [AudioPlaybackController]?
var cubett: ModelEntity?

var aircraftPlaceHolder = Aircraft(name: "", origin: .EuropeanConsortiumUKGermanyItalySpain, yearIntroduced: 2000, status: .active, Manufacturer: "", description: "", topSpeed: 100, modelPathName: "",sound: .jetPlaneNoise, animationType: .agile_fast_plane)
