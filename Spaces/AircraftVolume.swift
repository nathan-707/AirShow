//
//  AircraftVolume.swift
//  AirShow
//
//  Created by Nathan Eriksen on 3/22/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct AircraftVolume: View {
    @EnvironmentObject private var viewModel: theViewModel
    
    @EnvironmentObject private var airshowModel: theAirShowModel
    
    
    var body: some View {
        
        Model3D(named: (airshowModel.aircraftSelected.modelPathName), bundle: realityKitContentBundle) { model in
            model.resizable()
                .rotation3DEffect(Angle(degrees: 90), axis: (1, 0,0))
                .rotation3DEffect(Angle(degrees: 150), axis: (0, 1,0))
                .rotation3DEffect(Angle(degrees: 25), axis: (0, 0,1))
                .scaledToFit()
            
        } placeholder: {
            ProgressView().padding(50)
        }
    }
}

#Preview {
    AircraftVolume()
}
