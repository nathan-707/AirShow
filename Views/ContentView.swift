//
//  ContentView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import RealityKit
import StoreKit
import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.scenePhase) private var scenePhase

    #if os(visionOS)
        @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    #endif

    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var airshowModel: theAirShowModel

    @Query var dataModelQuery: [DataModel]

    var body: some View {

        VStack {
            switch viewModel.currentView {
            case .mainMenu:
                MainMenuView()
            case .adjustAircraftView:
                #if os(visionOS)
                    AircraftSettingsView()
                #endif

            case .customAirshowView:

                #if os(visionOS)
                    CustomAirshowView()
                #endif

            case .adjustCustomShowView:

                #if os(visionOS)
                    AdjustCustomShowView()
                #endif

            case .storeView:
                BuyAllPlanesView()
            case .ios_customAirshowView:
                #if os(iOS)
                    ios_CustomAirshowView()
                #endif

                #if os(visionOS)
                    EmptyView()
                #endif

            case .ios_AirShowView:

                #if os(iOS)
                    ZStack {
                        ios_AirShowView()
                        ios_adjustPlaneSettingsView()
                    }

                #endif
            }
        }.onAppear {
            initAirshow()
        }

        .onChange(of: scenePhase) { oldValue, newValue in

            switch newValue {
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

func initAirshow() {

    // init sound
    initAudio()

}

let buyAllPlaneInAppPurchaseID = "airshow.accessToAllPlanes"
