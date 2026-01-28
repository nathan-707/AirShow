//
//  ios_MainMenu.swift
//  AirShow
//
//  Created by Nathan Eriksen on 10/26/25.
//

import SwiftUI

#if os(iOS)
    struct MainMenuView: View {
        @EnvironmentObject var viewModel: theViewModel
        @EnvironmentObject var airshowModel: theAirShowModel
        @EnvironmentObject var storeModel: Store
        @State var loading = false
        var body: some View {

            if loading {
                ProgressView()
            } else {
                
                VStack{
                    
                    Button {
                        
                        airshowModel.planesInCustomAirshow.append(F35_Lightning2)
                        airshowModel.planesInCustomAirshow.append(stealthBomber)
                        airshowModel.planesInCustomAirshow.append(warthog)

                        viewModel.currentView = .ios_customAirshowView
                        
                    } label: {
                        Text("Custom Show")
                    }
                    
                    
                    List {
                        ForEach(getFilter(viewModel: viewModel)) { aircraft in
                            Button {
                                loading = true
                                airshowModel.aircraftSelected = aircraft
                                viewModel.currentView = .ios_AirShowView
                            } label: {
                                if aircraft.needToPurchase == true
                                    && storeModel.upgraded == false
                                {
                                    Text(aircraft.name).foregroundStyle(
                                        .secondary
                                    )
                                } else {
                                    Text(aircraft.name)
                                }
                            }
                        }

                    }
                    
                }
               
                
                
            }

        }
    }

    #Preview {
        MainMenuView()
    }
#endif
