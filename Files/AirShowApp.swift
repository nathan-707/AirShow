//
//  AirShowApp.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import SwiftData
import SwiftUI

@main
struct AirShowApp: App {

    @State var viewModel = ViewModel()
    @State var airshowModel = theAirShowModel()
    @State var storeModel = Store()

    var body: some Scene {

        #if os(iOS)

            WindowGroup(id: "windowGroup") {
                ContentView()
                    .environmentObject(viewModel)
                    .environmentObject(airshowModel)
                    .environmentObject(storeModel)
            }
        #endif

        #if os(visionOS)

            WindowGroup(id: "windowGroup") {
                ContentView()
                    .environmentObject(viewModel)
                    .environmentObject(airshowModel)
                    .environmentObject(storeModel)

            }.windowStyle(.plain)
                .defaultSize(width: 1550, height: 1000)
                .modelContainer(for: [DataModel.self])
        
        


            ImmersiveSpace(id: "airshowspace") {
                AirshowView().environmentObject(viewModel).environmentObject(
                    airshowModel
                ).environmentObject(storeModel)
            }.immersionStyle(
                selection: $viewModel.immersionStyle,
                in: .progressive,
                .mixed
            )
            .immersiveEnvironmentBehavior(.coexist)
        
        
      
            
        
        
        
            ImmersiveSpace(id: "showroomspace") {
                ShowRoom().environmentObject(viewModel).environmentObject(
                    airshowModel
                ).environmentObject(storeModel)
            }.immersionStyle(
                selection: $viewModel.immersionStyle,
                in: .progressive,
                .mixed
            )

            ImmersiveSpace(id: "customAirshowSpace") {
                customAirshowSpace().environmentObject(viewModel)
                    .environmentObject(airshowModel).environmentObject(
                        storeModel
                    )
            }.immersionStyle(
                selection: $viewModel.immersionStyle,
                in: .progressive,
                .mixed
            )
        
            .immersiveEnvironmentBehavior(.coexist)


            WindowGroup(id: "myVolume") {
                AircraftVolume()
            }

            .environmentObject(viewModel).environmentObject(airshowModel)
            .environmentObject(storeModel)
            .windowStyle(.volumetric)
            .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        #endif

    }

    init() {
        AirshowSystem.registerSystem()
    }
}
