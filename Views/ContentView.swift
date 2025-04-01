//
//  ContentView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import SwiftUI
import RealityKit
import StoreKit
import SwiftData



struct ContentView: View {

    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @EnvironmentObject var viewModel: theViewModel
    @EnvironmentObject var airshowModel: theAirShowModel
    
    @Query var dataModelQuery: [DataModel]

    
    var body: some View {
        
        VStack {
            switch viewModel.currentView {
            case .mainMenu:
                MainMenuView()
            case .adjustAircraftView:
                AircraftSettingsView()
            case .customAirshowView:
                CustomAirshowView()
            case .adjustCustomShowView:
                AdjustCustomShowView()
            case .storeView:
                BuyAllPlanesView()
            }
        }.onAppear(){
            initAirshow()
        }
        
        .onChange(of: scenePhase) { oldValue, newValue in
            
            switch newValue{
            case .background:
//                viewModel.currentView = .mainMenu
//                Task{ // this might be making no windows appear when user opens the app.
//                    await dismissImmersiveSpace()
//                }
//                loadingPlanesGlobal = true
//                viewModel.isLoadingPlanes = true
                
                break
            case .inactive:
//                loadingPlanesGlobal = true
//                viewModel.isLoadingPlanes = true
                print("inactive")
                break
            case .active:
                print("Active")
                break
            @unknown default:
                break
            }
        }
    }
}

func initAirshow(){
    
    // init sound
    initAudio()
    
}




let buyAllPlaneInAppPurchaseID = "airshow.accessToAllPlanes"

