//
//  Parameters.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/9/24.
//

import Foundation
import RealityKit
import SwiftUI
import AVKit
import AVFAudio

var startingDistance: Float = -2500 // starting distance used when viewing the aircraft.
let secondsInBetweenSpawn: Double = 5 // time between spawnning another aircraft in custom show.
let maxNumberOfAircraftAtOneTimeInChaotic = 14



//let spatialPlaneEngineReverb: Audio.Decibel = -.infinity
//let spatialFlyoverReverb: Audio.Decibel = -.infinity

let spatialPlaneEngineReverb: Audio.Decibel = -.infinity
let spatialFlyoverReverb: Audio.Decibel = -35
