//
//  CustomAirshowView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/13/24.
//

import SwiftUI
#if os(visionOS)

struct CustomAirshowView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var airshowModel: theAirShowModel
    @EnvironmentObject private var storeModel: Store
    
    @State var planeToAddToCustomShow: Aircraft = allAircrafts.first!
    
    @State var selectedAircrafts = 0
    
    var body: some View {
        
        VStack{
            Text("SELECT LINE UP").font(.extraLargeTitle2).padding()

            
            if selectedAircrafts == 0 {
                Text("\(selectedAircrafts) selected").foregroundStyle(.red).font(.headline).bold()
                
            } else {
                Text("\(selectedAircrafts) selected").foregroundStyle(.green).font(.headline).bold()
            }
            
            HStack{
                Button{
                    
                    airshowModel.planesInCustomAirshow.removeAll()
                    selectedAircrafts = 0
                
                    for aircraft in allAircrafts{
                        if storeModel.upgraded || aircraft.needToPurchase == false {
                            selectedAircrafts += 1
                            
                            airshowModel.planesInCustomAirshow.append(aircraft)
                        }
                    }
                    
                } label: {
                    Text("Add All").bold().padding(3)
                }
                
                if !airshowModel.planesInCustomAirshow.isEmpty{
                    Button{
                        selectedAircrafts = 0
                        
                        airshowModel.planesInCustomAirshow.removeAll()
                    } label: {
                        Text("Remove All").bold()
                    }
                }
            }
            
            HStack{
                ScrollView {
                    
                    ForEach(allAircrafts){ aircraft in
                        if aircraft.needToPurchase == false || storeModel.upgraded == true {
                            if !airshowModel.planesInCustomAirshow.contains(aircraft){
                                Button {
                                    selectedAircrafts += 1
                                    airshowModel.planesInCustomAirshow.append(aircraft)
                                } label: {
                                    ZStack{
                                        Rectangle().frame(width: 200, height: 50).foregroundStyle(.clear)
                                        Text(aircraft.name).foregroundStyle(.white).font(.title)
                                    }.padding(10)
                                }
                            } else {
                                
                                Text("- - - - -").padding(25).font(.largeTitle)
                                
                            }
                        }
                    }.padding()
                }.padding(.trailing, 150)
                
                VStack{
                    
                    ScrollView{
                        
                        if !airshowModel.planesInCustomAirshow.isEmpty {
                            
                            ForEach(airshowModel.planesInCustomAirshow){ aircraft in
                                Text(aircraft.name).foregroundStyle(.green).font(.title).padding(10)
                            }
                            
                        } else {
                            Text("- - - - -").padding().foregroundColor(.red).font(.extraLargeTitle)

                        }
                    }
                }.padding()
            }
            
            Spacer()

            Divider()
            

            HStack{
                
                Text("Show Type:").font(.largeTitle).bold()
                
                Picker("LocalizedStringKey", selection: $airshowModel.showType) {
                    Text("Classic").tag(ShowType.classic)
                    Text("Chaotic").tag(ShowType.chaos)
                }
                
                
                PickEnvironment().padding()

                
                HStack {
                    
                    Text("Speed:").font(.largeTitle).bold()
                    
                    Picker("LocalizedStringKey", selection: $airshowModel.classicShowSpeedBoost) {
                        Text("Fast").tag(Boost.fast)
                        Text("Realistic").tag(Boost.normal)
                        Text("Slow").tag(Boost.slow)
                    }
                    
                }.padding()
                
                
                
            }.padding()
            
            Divider()

            HStack{
                
                if !airshowModel.planesInCustomAirshow.isEmpty{
                    
                    Button {
                        // TODO: pen custom air show space
                        Task {
                            viewModel.isLoadingPlanes = true
                            viewModel.numberOfPlanes = 0
                            viewModel.planeThatsLoading = 0
                            viewModel.currentView = .adjustCustomShowView

                            let result = await openImmersiveSpace(id: "customAirshowSpace")
                            switch result{
                            case .opened:
                                break
                            case .userCancelled:
                                viewModel.currentView = .mainMenu
                            case .error:
                                viewModel.currentView = .mainMenu
                            @unknown default:
                                break
                            }
                        }
               
                        
                    } label: {
                        Text("START SHOW").foregroundStyle(.green).font(.title).bold().padding()
                    }.padding()
                } else {
                    Text("ADD AIRCRAFTS TO START SHOW").bold().font(.title).foregroundStyle(.red).padding()
                }
            }
            
            Button {
                viewModel.currentView = .mainMenu
            } label: {
                Text("BACK").bold().foregroundStyle(.orange).font(.title).padding()
            }.padding()
            
        }
        .background()
        .onAppear(){
            airshowModel.chaoticShow = false
//            airshowModel.showType = .classic
            selectedAircrafts = airshowModel.planesInCustomAirshow.count
        }
    }
    
}

#Preview {
    CustomAirshowView()
}
#endif
