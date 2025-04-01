//
//  AirShowApp.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import SwiftUI
import SwiftData


@main
struct AirShowApp: App {
    
    @State var viewModel = theViewModel()
    @State var airshowModel = theAirShowModel()
    @State var storeModel = Store()
    
    
    var body: some Scene {
        
        WindowGroup(id: "windowGroup") {
            ContentView().environmentObject(viewModel)
                .environmentObject(airshowModel)
                .environmentObject(storeModel)
            
        }.windowStyle(.plain)
            .defaultSize(width: 1550, height: 1000)
            .modelContainer(for: [DataModel.self])
        
        
        ImmersiveSpace(id: "airshowspace"){
            AirshowView().environmentObject(viewModel).environmentObject(airshowModel).environmentObject(storeModel)
        }.immersionStyle(selection: $viewModel.immersionStyle, in: .progressive, .mixed)
        
        ImmersiveSpace(id: "showroomspace"){
            ShowRoom().environmentObject(viewModel).environmentObject(airshowModel).environmentObject(storeModel)
        }.immersionStyle(selection: $viewModel.immersionStyle, in: .progressive, .mixed)
        
        ImmersiveSpace(id: "customAirshowSpace") {
            customAirshowSpace().environmentObject(viewModel).environmentObject(airshowModel).environmentObject(storeModel)
        }.immersionStyle(selection: $viewModel.immersionStyle, in: .progressive, .mixed)
        
        WindowGroup(id: "myVolume") {
            AircraftVolume()
        }
        
        .environmentObject(viewModel).environmentObject(airshowModel).environmentObject(storeModel)
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        
    }
    
    init() {
        AirshowSystem.registerSystem()
    }
}
