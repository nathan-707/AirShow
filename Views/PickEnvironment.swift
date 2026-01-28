//
//  PickEnvironment.swift
//  AirShow
//
//  Created by Nathan Eriksen on 4/3/24.
// 

import SwiftUI


#if os(visionOS)


struct PickEnvironment: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    var body: some View {
        
        HStack{
            Text("Environment:").font(.largeTitle).bold()
            
            Picker("", selection: $viewModel.selectedEnvironment){
                Text("System Environment").tag(FullSpaceSetting.none)
                
//                Text("System Environment").tag(FullSpaceSetting.systemEnvironment)
                
                Text("Hills (Daytime)").tag(FullSpaceSetting.daytime)
                Text("Ocean (Daytime)").tag(FullSpaceSetting.ocean)
//                Text("City (Daytime)").tag(FullSpaceSetting.test4)
//                Text("Quarry (Sunset)").tag(FullSpaceSetting.sunsetQuarry)
                Text("Mountains (Dusk)").tag(FullSpaceSetting.test1)
                
                // Text("Trees (Dusk)").tag(FullSpaceSetting.test2)
                
//                Text("Crop Field (Dusk)").tag(FullSpaceSetting.test5)
                Text("Field (Night)").tag(FullSpaceSetting.starsNight)
            }.onChange(of: viewModel.selectedEnvironment) { oldValue, newValue in
                if newValue == .none {
                    viewModel.immersionStyle = .mixed
                } else {
                    viewModel.immersionStyle = .progressive
                }
            }
        }
    }
}

#Preview {
    PickEnvironment()
}

#endif
