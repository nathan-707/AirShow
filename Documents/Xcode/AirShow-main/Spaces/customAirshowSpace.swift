//
//  customAirshowSpace.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct customAirshowSpace: View {
    
    @State var timer: Timer?
    
    
    @EnvironmentObject private var viewModel: theViewModel
    @EnvironmentObject private var airshowModel: theAirShowModel
    @State var loaded = false
    
    @State var animationSub: EventSubscription?
    
    var body: some View {
        
        if !viewModel.isLoadingPlanes {
            BackGroundView().environmentObject(viewModel)
        }
        
        RealityView { content in
            
            guard let ParticleScene = try? await Entity(named: "smokeTrail", in: realityKitContentBundle) else {
                viewModel.currentView = .mainMenu
                return
            }
            
            // assign resources from reality composer to their varibles to be cloned.
            graySmoke = ParticleScene.findEntity(named: "smokeTrail")!
            
            guard let animationScene = try? await Entity(named: "Animation", in: realityKitContentBundle) else {
                viewModel.currentView = .mainMenu
                return
            }
        
            loadAnimations(scene: animationScene)
            
            animationSub = content.subscribe(to: AnimationEvents.PlaybackCompleted.self, { Event in
                airshowModel.custom_animationEnded(aircraftController: Event.playbackController)
            })
            
            origin_Aircraft = Entity()
            
            content.add(origin_Aircraft)
            

            await setup(content)
            
            loaded = true
            
            if airshowModel.showType == .chaos {
                airshowModel.custom_startChaoticAirshow()
                
            } else {
                airshowModel.startClassicAirshow()
            }
    
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30, repeats: true) {  _ in
                if airshowModel.showType == .classic { // right now only need to check frames every second for the classic type.
                    classicFrameUpdate()
                }
                
                if airshowModel.showType == .chaos {
                    airshowModel.customShowFrameUpdate()
                }
            }
        }
        
        .onDisappear {
            viewModel.currentView = .mainMenu
            airshowModel.deinitShow()
            timer?.invalidate()
            timer = nil
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ tap in // BOOM
            // handle tap gestures here if the game is not paused only.
            spankCounter += 1
            print("spank \(spankCounter)")
            
        }))
        
        
    }
    
    func setup(_: RealityViewContent) async {
        
        airshowModel.soundDelay = true
        
        loadingPlanesGlobal = true
        
        
        for plane in airshowModel.planesInCustomAirshow {
            do {
                viewModel.planeThatsLoading += 1
                plane.mEntity = try await Entity(named: plane.modelPathName, in: realityKitContentBundle).clone(recursive: true)
                
            } catch {
                viewModel.planeThatsLoading = 0
                print(plane.name)
                print("ERROR LOADING or aborted")
                viewModel.currentView = .mainMenu
                return
            }
        }
        
        loadingPlanesGlobal = false
        
        viewModel.isLoadingPlanes = false
    }
    
    func onAnimationCompleted(){}
    
    
    func classicFrameUpdate(){
        
        if !viewModel.isLoadingPlanes{
            for aniamtionRoot in origin_Aircraft.children {
                if let group = aniamtionRoot.children.first {
                    if let aircraft = group.children.first {
                        if aircraft.position(relativeTo: origin_Aircraft).z > 20 && aircraft.position(relativeTo: origin_Aircraft).z < 23 {
                            
                            if let aircraftComponent = aircraft.components[AircraftComponent.self]{
                                if aircraftComponent.ignore == false {
                                    
                                    if airshowModel.classicShow_automatic {
                                        ignoreAllCurrentAircrafts()
                                        airshowModel.classicSpawnNextPlane()
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if lastCount != origin_Aircraft.children.count {
            lastCount = origin_Aircraft.children.count
            print(origin_Aircraft.children.count)
        }
    }
}



func ignoreAllCurrentAircrafts(){
    
    for anchor in origin_Aircraft.children {
        if let origin = anchor.children.first {
            if let aircraft = origin.children.first{
                
                if let currentAircraftComponent = aircraft.components[AircraftComponent.self]{
                    currentAircraftComponent.ignore = true
                    aircraft.components.set(currentAircraftComponent)
                }
                
            }
        }
    }
}

var lastCount = 0

func createHitBox() -> ModelEntity {
    let hitBox = ModelEntity(mesh: .generateSphere(radius: 10), materials: [UnlitMaterial(color: .purple)])
    hitBox.components.set(InputTargetComponent())
    
    hitBox.components.set(CollisionComponent(shapes: [.generateSphere(radius: 10)]))
    hitBox.components.set(PhysicsBodyComponent(massProperties: .default, material: .default, mode: .kinematic))
    
    return hitBox
}

var numberOfPlanesToLoad = 0

#Preview {
    customAirshowSpace()
}

var spankCounter = 0
var loadingPlanesGlobal = true

