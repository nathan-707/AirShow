//
//  ios_customAirShowView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 10/26/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

#if os(iOS)

    struct ios_AirShowView: View {

        @EnvironmentObject var viewModel: theViewModel
        @EnvironmentObject var airshowModel: theAirShowModel
        
        @State var animationSub: EventSubscription?
        @State var timer: Timer?

        var body: some View {
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
                airshowModel.speed = 34
                airshowModel.formation = 3
                origin_Aircraft = Entity()
                airshowModel.spawnPlaneFormation()
                
                // Create horizontal plane anchor for the content
                
//                let anchor = AnchorEntity()
//                anchor.addChild(origin_Aircraft)

                // Add the horizontal plane anchor to the scene
                content.add(origin_Aircraft)
                


                content.camera = .spatialTracking
            }
            .edgesIgnoringSafeArea(.all)
        }

    }

    #Preview {
        ios_AirShowView()
    }
#endif

