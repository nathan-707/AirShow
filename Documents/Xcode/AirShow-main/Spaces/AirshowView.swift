//
//  AirshowView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct AirshowView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var viewModel: theViewModel
    @EnvironmentObject private var airshowModel: theAirShowModel
    @State var animationSub: EventSubscription?
    @State var timer: Timer?

    var body: some View {
        BackGroundView().environmentObject(viewModel)
        
        RealityView { content in
            guard let Scene = try? await Entity(named: airshowModel.aircraftSelected.modelPathName, in: realityKitContentBundle) else {
                viewModel.currentView = .mainMenu
                return
            }
            guard let ParticleScene = try? await Entity(named: "smokeTrail", in: realityKitContentBundle) else {
                viewModel.currentView = .mainMenu
                return
            }
            guard let animationScene = try? await Entity(named: "Animation", in: realityKitContentBundle) else {
                viewModel.currentView = .mainMenu
                return}
            loadAnimations(scene: animationScene)
            // assign resources from reality composer to their varibles to be cloned.
            graySmoke = ParticleScene.findEntity(named: "smokeTrail")!
            
            selectedAircraftModel = Scene.findEntity(named: airshowModel.aircraftSelected.modelPathName)!.clone(recursive: true)
            airshowModel.aircraftSelected.mEntity = Scene.findEntity(named: airshowModel.aircraftSelected.modelPathName)!.clone(recursive: true)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 45, repeats: true) {  _ in
                airshowModel.frameUpdate()
            }
            animationSub = content.subscribe(to: AnimationEvents.PlaybackCompleted.self, { Event in
                airshowModel.custom_animationEnded(aircraftController: Event.playbackController)
            })
            // init and add origins.
            origin_Aircraft = Entity()
            content.add(origin_Aircraft)
            airshowModel.spawnPlaneFormation()
        }     
        .onDisappear{
            timer?.invalidate()
            timer = nil
            viewModel.currentView = .mainMenu
            airshowModel.deinitShow()
        }
    }
}



func findChildNamed(_ name: String, in node: Entity) -> Entity? {
    if node.name == name {
        return node
    }
    for child in node.children {
        if let foundChild = findChildNamed(name, in: child) {
            return foundChild
        }
    }
    return nil
}


