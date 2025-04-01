//
//  ShowRoom.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/16/23.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct ShowRoom: View {
    
    let heightt: Float = 0
    
    @State var collisionSub:EventSubscription?
    @State var ShowRoomScene = Entity()
    @State var showRoomOrigin = Entity()
    @State var planeModelArray = [Entity()]
    @State var planeToLand = Entity()
    @State var landed: Bool = false
    @EnvironmentObject private var viewModel: theViewModel
    
    var body: some View {
        
        if viewModel.showRoomIsLoaded == true{
            BackGroundView()
        }
        
        RealityView { content in
        
            collisionSub = content.subscribe(
                to: CollisionEvents.Began.self,
                on: content as? EventSource
            ) { event in
                collisionDetected(event: event)
            }
            
            await setup(content)
            content.add(showRoomOrigin)
            postionAircrafts()
            viewModel.showRoomIsLoaded = true
        }.onDisappear(){
            viewModel.showRoom = false
            viewModel.showRoomIsLoaded = false
        }
    }
    
    func collisionDetected(event: CollisionEvents.Began){
        
        print(event.entityA.name)
        if event.entityA == planeToLand ||  event.entityB == planeToLand{
            landed = true
        }
    }
    
    func postionAircrafts() {
        
        let increment: Float = 40
        var position: Float = 250
        let numberOfPlanes = allAircrafts.count
        print("count")
        print(numberOfPlanes)
        let leftRow = numberOfPlanes / 2
        print(leftRow)
        print("left row")
        var counter = 0
        for planeToPosition in planeModelArray {
            counter += 1
            
            if (counter <= leftRow) { // left row
                planeToPosition.setPosition(SIMD3<Float>(0,heightt,position), relativeTo: showRoomOrigin)
                planeToPosition.setOrientation(simd_quatf(angle: 100, axis: SIMD3<Float>(0,1,0)), relativeTo: planeToPosition)
                position -= increment
            }
            
            else { // right row
                planeToPosition.setPosition(SIMD3<Float>(increment,heightt, position), relativeTo: showRoomOrigin)
                planeToPosition.setOrientation(simd_quatf(angle: -100, axis: SIMD3<Float>(0,1,0)), relativeTo: planeToPosition)
                position += increment
            }
            
            setupPhysics(planeToSetUp: planeToPosition)
            showRoomOrigin.addChild(planeToPosition)
        }
    }
    
    
    func setupPhysics(planeToSetUp: Entity) {
    
        planeToSetUp.components.set(CollisionComponent(shapes: [.generateBox(size: SIMD3<Float>(10, 3, 10))], isStatic: false))
        planeToSetUp.components.set(PhysicsBodyComponent(massProperties: .init(shape: .generateBox(size: SIMD3<Float>(10,3,10)), mass: 100), material: .generate(friction: 100, restitution: 0), mode: .kinematic))
    }
    
    func setup(_: RealityViewContent) async {
        
        showRoomOrigin = Entity()
    
//        if viewModel.selectedEnvironment != .none {
            ShowRoomScene = try! await Entity(named: "ShowRoom", in: realityKitContentBundle)
            showRoomOrigin.addChild(ShowRoomScene)
//        }
        
        
        
        for plane in allAircrafts {
            print(plane.name)
                let planeModelToAdd = try! await Entity(named: plane.modelPathName, in: realityKitContentBundle)
                planeModelArray.append(planeModelToAdd)

        }
    }
}


#Preview {
    ShowRoom()
}

