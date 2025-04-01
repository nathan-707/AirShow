//
//  AdjustCustomShowView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/14/24.
//

import SwiftUI
import RealityKit

var waitforplanes = true

struct AdjustCustomShowView: View {
    
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @EnvironmentObject private var viewModel: theViewModel
    @EnvironmentObject private var airshowModel: theAirShowModel
    @State var superSonic = false
    @State var messegeOver = false
    @State var showInfo = true
    @State var paused = false
    
    var body: some View {
        
        VStack {
            
            if viewModel.isLoadingPlanes == true {
                VStack {
                    ProgressView()
                    Text("Loading Show").bold().padding()
                    Text("\(viewModel.planeThatsLoading) / \(numberOfPlanesToLoad)").bold()
                }.padding()
            } else {
                
                if airshowModel.showType == .classic {
                    
                    VStack {
                        
                        if !messegeOver {
                            HStack{
                                
                                if showInfo {
                                    Text(" " + String(airshowModel.classicShowIndex) + "/" + String(airshowModel.planesInCustomAirshow.count)).padding().font(.headline)
                                }
                                
                                Spacer()
                                
                                Text("NOW SHOWING: ").font(.title).bold()
                                Text(airshowModel.nowShowing.name).font(.title).foregroundStyle(.green).textCase(.uppercase)
                                
                                Spacer()
                                
                            }
                            
                        } else {
                            Text("END OF SHOW").font(.title).bold().foregroundStyle(.red)
                        }
                    }
                    
                    if showInfo{
                        MoreInfoView()
                    }
                    
                    if showInfo {
                        
                        Toggle(isOn: $airshowModel.classicShow_automatic) {
                            Text("SEND NEXT AUTOMATICALLY:").bold()
                        }.background()
                            .onChange(of: airshowModel.classicShow_automatic) { oldValue, newValue in
                                if newValue == true {
                                    print(origin_Aircraft.children.count)
                                    if checkToSpawnNext() {
                                        airshowModel.classicSpawnNextPlane()
                                    }
                                }
                            }
                    }
                    
                    
                    HStack{
                        
                        Button{
                            showInfo.toggle()
                        } label: {
                            if showInfo {
                                Text("HIDE INFO")
                            } else {
                                Text("SHOW INFO")
                            }
                        }.padding(15)
                            .onChange(of: showInfo) { oldValue, newValue in
                            if newValue == false {
                                airshowModel.classicShow_automatic = true
                            }
                        }
                        
                        if !messegeOver {
                            
                            Button {
                                if airshowModel.classicShow_automatic {
                                    origin_Aircraft.children.removeAll()
                                }
                                airshowModel.classicSpawnNextPlane()
                                
                            } label: {
                                Text("NEXT")
                            }
                        }
                        
                        if messegeOver {
                            
                            Spacer()
                            
                            Button{
                                messegeOver = false
                                airshowModel.startClassicAirshow()
                                
                            } label: {
                                
                                Text("RESTART CLASSIC SHOW").foregroundStyle(.red).bold()
                                
                            }.padding(15)
                            
                            Button {
                                airshowModel.showType = .chaos
                                airshowModel.custom_startChaoticAirshow()
                            } label: {
                                Text("START CHAOTIC SHOW").foregroundStyle(.red).bold()
                            }.padding(15)
                            
                            
                        }
                    }
                }
                
                if airshowModel.showType == .chaos {
                    Text("CHAOTIC SHOW").font(.title).bold().padding()
                }
                
                Button {
                    viewModel.currentView = .mainMenu
                    Task { await dismissImmersiveSpace() }
                } label: {
                    Text("EXIT")
                }.padding(.bottom, 50)
            }
        }.onChange(of: airshowModel.showOver) { oldValue, newValue in
            messegeOver = newValue
        }
        .onAppear(){
            viewModel.isLoadingPlanes = true
            numberOfPlanesToLoad = airshowModel.planesInCustomAirshow.count
            viewModel.planeThatsLoading = 0
        }
        .onDisappear(){
            viewModel.currentView = .mainMenu
            

        }
    }
    
    
    func checkToSpawnNext() -> Bool{
        
        let answer = false
        
        //        for anchor in origin_Aircraft.children {
        //            if let aircraft = anchor.children.first {
        //                if aircraft.position.z > -10 {
        //
        //                    answer = true
        //                } else {
        //                    return false
        //                }
        //            }
        //        }
        //
        return answer
    }
}




#Preview {
    AdjustCustomShowView()
}
