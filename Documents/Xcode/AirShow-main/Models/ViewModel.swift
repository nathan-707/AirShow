//
//  ViewModel.swift
//  AirShow
//
//  Created by Nathan Eriksen on 8/10/23.
//

import Foundation
import RealityKit
//import RealityKitContent
import SwiftUI

enum planeBehavior {
    case toward, side, rotate
}

enum views {
    case mainMenu, adjustAircraftView, customAirshowView, adjustCustomShowView, storeView
}

enum environments {
    case progressiveSpace, mixedReality
}

enum ShowType {
    case classic, chaos
}

enum units {
    case milePerHour, kilometersPerHour
}

class theViewModel: ObservableObject {
    @Published var userUnits: units = .milePerHour
    @Published var selectedEnvironment: FullSpaceSetting = .none // default user environment
    @Published var speedInMPH: Float = 400                          // default user speed when viewing
    
    
    
    // customShow settings.
    @Published var purchaseVerified = false
    @Published var isLoadingPlanes = true
    @Published var userSelectedStyle: environments = .progressiveSpace
    @Published var currentView: views = .mainMenu
    @Published var immersionStyle: ImmersionStyle = .progressive
    @Published var hideLandingGear = false
    @Published var updateSpeed: Bool = true
    @Published var showRoom: Bool = false
    @Published var showRoomIsLoaded: Bool = false
    @Published var filter: sortEnum = .free
    @Published var numberOfPlanes: Float = 2
    @Published var showFull = false
    @Published var planeThatsLoading = 0
    @Published var showModelPreview = true
    
    
    
    
    init(){
        if self.selectedEnvironment == .none {
            self.immersionStyle = .mixed
        } else {
            self.immersionStyle = .progressive
        }
    }
    
}





