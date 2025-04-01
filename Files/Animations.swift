//
//  Animations.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/18/24.
//


/* maya notes.
 maya export units: centimeters
 reality coverter units: cemtimeters
 
 did not change the scale factor in reality composer.
 
 */


import Foundation
import RealityKit

let testingOnlyOneAnimation = false

// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// entities for loading animations. also add them to the loadAnimations function below
var animation1 = Entity() // agile.
var animation2 = Entity() // all.
var animation3 = Entity() // all.
var animation4 = Entity() // all.
var animation5 = Entity() // agile
var animation6 = Entity() // all.
var animation7 = Entity() // agile.
var animation8 = Entity() // all.
var animation9 = Entity() // agile.
var animation10 = Entity() // agile.
var animation11 = Entity() // agile.
var animation12 = Entity() // agile.



// DON'T FORGET TO ADD THEM HERE TOO!!
func loadAnimations(scene: Entity){
    
    animation1 = find_assign(entityName: "animation1")
    animation2 = find_assign(entityName: "animation2")
    animation3 = find_assign(entityName: "animation3")
    animation4 = find_assign(entityName: "animation4")
    animation5 = find_assign(entityName: "animation5")
    animation6 = find_assign(entityName: "animation6")
    animation7 = find_assign(entityName: "animation7")
    animation8 = find_assign(entityName: "animation8")
    animation9 = find_assign(entityName: "animation9")
    animation10 = find_assign(entityName: "animation10")
    animation11 = find_assign(entityName: "animation11")
    animation12 = find_assign(entityName: "animation12")
    
    func find_assign(entityName: String) -> Entity {
        return scene.findEntity(named: entityName)!
    }
}
// ------------------------------------------------------------------------------------------------------

let agileAnimationBaseSpeed: Float = 3.0
let allPlaneBaseSpeed: Float = 2.9

/*
 VStack{
     Text("Origin:").bold().font(.largeTitle).foregroundStyle(.orange).padding(.top,space)
     Text(printOrigin(origin: airshowModel.aircraftSelected.origin)).font(.title)
         
 }.padding()
 
 */
// ------------------------------------------------------------------------------------------------------
func slowDownAgileAnimationPercent(input: Float) -> Float { return input * (0.42) } // for the slow agile planes, multiply the agile animations by this to decrease speed.
func slowDownHelicopterPercent(input: Float) -> Float {return input * 0.41}
func slowDownLargeAnimationPercent(input: Float) -> Float { return input * (0.45) } // for the slow large planes, multiply the large plane animations by this to decrease speed.
// ------------------------------------------------------------------------------------------------------

// CUSTOM ANIMATION DECLARATIONS ------------------------------------------------------------------------
let customAnimation1 = CustomAnimation(animationEntity: animation1, speed: 2, typeOfAnimation: .agile)
let customAnimation2 = CustomAnimation(animationEntity: animation2, speed: allPlaneBaseSpeed + 0.1, typeOfAnimation: .all)
let customAnimation3 = CustomAnimation(animationEntity: animation3, speed: allPlaneBaseSpeed - 0.5, typeOfAnimation: .all)
let customAnimation4 = CustomAnimation(animationEntity: animation4, speed: allPlaneBaseSpeed - 0.5, typeOfAnimation: .all)
let customAnimation5 = CustomAnimation(animationEntity: animation5, speed: agileAnimationBaseSpeed, typeOfAnimation: .agile)
let customAnimation6 = CustomAnimation(animationEntity: animation6, speed: allPlaneBaseSpeed - 0.7, typeOfAnimation: .all)
let customAnimation7 = CustomAnimation(animationEntity: animation7, speed: agileAnimationBaseSpeed, typeOfAnimation: .agile)
let customAnimation8 = CustomAnimation(animationEntity: animation8, speed: allPlaneBaseSpeed + 0.7, typeOfAnimation: .all)
let customAnimation9 = CustomAnimation(animationEntity: animation9, speed: agileAnimationBaseSpeed + 0.5, typeOfAnimation: .agile)
let customAnimation10 = CustomAnimation(animationEntity: animation10, speed: agileAnimationBaseSpeed, typeOfAnimation: .agile)
let customAnimation11 = CustomAnimation(animationEntity: animation11, speed: agileAnimationBaseSpeed, typeOfAnimation: .agile)
let customAnimation12 = CustomAnimation(animationEntity: animation12, speed: agileAnimationBaseSpeed, typeOfAnimation: .agile)


// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------

let animationToTest = customAnimation1 // change to the animation to test when test button is pressed.



let animationsThatWorkForAnyAircraft: [CustomAnimation] = [
    customAnimation2,
    customAnimation3,
    customAnimation4,
    customAnimation6,
    customAnimation8,
]
// AGILE PLANE ANIMATION SETUP --------------------------------------------------------------------------
let agile_plane_animations: [CustomAnimation] = [
    customAnimation5,
    customAnimation5,
    customAnimation7,
    customAnimation9,
    customAnimation10,
    customAnimation11,
    customAnimation12,
    
    // animations that are meant for all aircrafts, that are also in the agile animation set.
    customAnimation2,
    customAnimation8
    
]
// ------------------------------------------------------------------------------------------------------


// LARGE PLANE ANIMATION SETUP---------------------------------------------------------------------------
let large_plane_animations: [CustomAnimation] = [
    customAnimation2,
    customAnimation3,
    customAnimation3,
    customAnimation4,
    customAnimation6,
    customAnimation8
]
// ------------------------------------------------------------------------------------------------------


// HELICOPTER PLANE ANIMATION SETUP ---------------------------------------------------------------------
let helicopter_animations: [CustomAnimation] = [
    customAnimation2,
    customAnimation3,
    customAnimation3,
    customAnimation4,
//    customAnimation6, // animation where it dips down.
    customAnimation8
    
]
// ------------------------------------------------------------------------------------------------------

enum typesOfAmimation {
    case plane, slow_plane, helicopter
}

let placeHolderEntity = Entity()

struct CustomAnimation {
    var animationEntity: Entity
    var speed: Float
    var typeOfAnimation: intendedAnimationType
}

enum intendedAnimationType {
    case all, agile, helicopter
}
