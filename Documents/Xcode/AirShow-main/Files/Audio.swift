//
//  Audio.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/10/24.
//

import Foundation
import RealityKit

//var largePlaneNoise_1: AudioResource?
var largePlaneNoise_2: AudioResource?
var sam: Int = 0

var jetNoise_2: AudioResource?
var jetNoise_3: AudioResource?
var jetNoise_4: AudioResource?

var jetNoise_5: AudioResource?
var jetNoise_6: AudioResource?
var jetNoise_7: AudioResource?
var jetNoise_8: AudioResource?
var jetNoise_9: AudioResource?


var jetOverHeadPassSound_1: AudioResource?
var jetOverHeadPassSound_2: AudioResource?

var propPassOverhead: AudioResource?
var propPassOverhead2 : AudioResource?
var propPassOverhead3: AudioResource?

var propellerNoise: AudioResource?
var propellerNoise2: AudioResource?

var helicopterNoise: AudioResource?


func loadLoopingResource(fileName: String) -> AudioResource {
    let resource = try!  AudioFileResource.load(named: fileName, configuration: AudioFileResource.Configuration.init(loadingStrategy: .stream, shouldLoop: true, shouldRandomizeStartTime: false, normalization: .none))
    return resource
}

func loadResource(fileName: String) -> AudioResource {
    let resource = try!  AudioFileResource.load(named: fileName, configuration: AudioFileResource.Configuration.init(loadingStrategy: .preload, shouldLoop: false, shouldRandomizeStartTime: false, normalization: .none))
    return resource
}


func initAudio(){
    
    // large plane sounds.
//    largePlaneNoise_1 = loadLoopingResource(fileName: "gtajet1")
    largePlaneNoise_2 = loadLoopingResource(fileName: "gtajet2")
    
    // jet plane sounds.
    jetNoise_2 = loadLoopingResource(fileName: "jetSound1")
    jetNoise_3 = loadLoopingResource(fileName: "jetSound2")
    jetNoise_4 = loadLoopingResource(fileName: "jetSound3")
    jetNoise_5 = loadLoopingResource(fileName: "jet1")
    jetNoise_6 = loadLoopingResource(fileName: "jet2")
    jetNoise_7 = loadLoopingResource(fileName: "jet3")
    jetNoise_8 = loadLoopingResource(fileName: "jet4")
    jetNoise_9 = loadLoopingResource(fileName: "jet5")
    
    // propeller plane sounds.
    propellerNoise = loadLoopingResource(fileName: "propSoundEngine1LOUD")
    propellerNoise2 = loadLoopingResource(fileName: "propSoundEngine2LOUD")
    
    // helicopter sounds.
    helicopterNoise = loadLoopingResource(fileName: "helicopterSound1")
    
    // jet plane pass over sounds.
    jetOverHeadPassSound_1 = loadResource(fileName: "passOver3")
    jetOverHeadPassSound_2 = loadResource(fileName: "jetFlyOverPassSound2")
    
    // prop plane pass over sounds.
    propPassOverhead = loadResource(fileName: "propPassover") 
    propPassOverhead2 = loadResource(fileName: "propPassOver2")
    propPassOverhead3 = loadResource(fileName: "propPassOver3")
    
}

let allPropPassOver = [
                        propPassOverhead,
]

let allJetPlaneNoises: [AudioResource] = [
    jetNoise_2!,
    jetNoise_3!,
    jetNoise_4!,
    jetNoise_5!,
    jetNoise_6!,
    jetNoise_7!,
    jetNoise_8!,
    jetNoise_9!]

let allJetOverHeadPassSounds: [AudioResource] = [jetOverHeadPassSound_1!, jetOverHeadPassSound_2!]

let allSmallPlaneNoises: [AudioResource] = allJetPlaneNoises // same as jet for now.

let allLargePlaneNoises: [AudioResource] = [
//    largePlaneNoise_1!,
    largePlaneNoise_2!, jetNoise_2!]

let allPropellerNoises: [AudioResource] = [propellerNoise!, propellerNoise2!]

let allHelicopeterNoises: [AudioResource] = [helicopterNoise!]


struct aircraftSoundEffectHandler {
    func randomJetPlaneNoise() -> AudioResource {
        return allJetPlaneNoises.randomElement()!
    }
   
    func randomPropellerNoise() -> AudioResource {
        return allPropellerNoises.randomElement()!
    }
    func randomLargePlaneNoise() -> AudioResource {
        return allLargePlaneNoises.randomElement()!
    }
    func randomHelicopterNoise() -> AudioResource {
        return allHelicopeterNoises.randomElement()!
    }
}


