//
//  AircraftSettingsView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/9/24.
//

import SwiftUI

#if os(visionOS)

let minSpeed: Float = 20

struct AircraftSettingsView: View {
    

    
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var airshowModel: theAirShowModel
    @State var superSonic = false
    
    @State var hideControls = false
    @State var topSpeed: Float = minSpeed + 3
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        
        if hideControls == false {
            
            VStack {
                HStack{
                    
                    Button{
                        airshowModel.spawnPlaneFormation()
                    } label: {
                        Text("SEND \(airshowModel.aircraftSelected.name)").textCase(.uppercase).bold().foregroundColor(.green)
                    }.padding()
                    
                    Spacer()
                    
                    HStack{
                        Text("FORMATION:").bold()
                        Picker("", selection: $airshowModel.formation) {
                            Text("SINGLE").tag(1)
                            Text("TRIO").tag(2)
                            Text("LARGE").tag(3)
                        }
                    }.padding()
                }
                
                HStack {
                    Text("ALTITUDE: ").font(.largeTitle)
                    
                    Slider(value: $airshowModel.height, in: -10 ... 1000) {}
                    
                    if viewModel.userUnits == .milePerHour {
                        Text("\(Int(airshowModel.height * 3.28084)) FEET").font(.largeTitle)

                    } else {
                        Text("\(Int(airshowModel.height)) METERS").font(.largeTitle)

                        
                    }
                    
                }.padding()
                
                HStack {
                    Text("SPEED: ").font(.largeTitle)
                    Slider(value: $airshowModel.speed, in: minSpeed ... topSpeed)
                        .onChange(of: airshowModel.speed) { oldValue, newValue in
                            if (newValue > 343){
                                superSonic = true
                            } else {
                                superSonic = false
                            }
                        }
                    
                    
                    if viewModel.userUnits == .milePerHour {
                        Text("\(Int(convertMetersPerSecondToMPH(meterPerSecond: airshowModel.speed))) MPH").font(.largeTitle)

                    } else {
                        Text("\(Int(convertMetersPerSecondToKPH(meterPerSecond: airshowModel.speed))) KPH").font(.largeTitle)
                    }
                }
                
                HStack{
                    
                    Spacer()
                    
                    VStack{
                        
                        if superSonic{
                            Text("(SUPERSONIC)").font(.title).foregroundStyle(.yellow).bold()
                        }
                        
                        if airshowModel.speed >= convertMPHToMetersPerSecond(miles: airshowModel.aircraftSelected.topSpeed - 3){
                            
                                Text("\(airshowModel.aircraftSelected.name) MAX SPEED").font(.headline).foregroundStyle(.red).bold()

                           
                            
                        }
                    }
                }
                
                HStack{
                    
                    Button{
                        hideControls.toggle()
                    } label: {
                        Text("HIDE CONTROLS").bold().foregroundStyle(.orange).padding()
                    }.padding()
                    
                    Button{
                        viewModel.currentView = .mainMenu
                        
                        
#if os(visionOS)
                        Task { await dismissImmersiveSpace() }
#endif
                        
                        
                    } label: {
                        Text("EXIT").padding().bold().foregroundColor(.orange)
                        
                    }.padding()
                }
            }
            .onAppear {
                topSpeed = convertMPHToMetersPerSecond(miles: airshowModel.aircraftSelected.topSpeed)
                initView()
            }
        }
        else {
            
            VStack{
                Button{
                    airshowModel.spawnPlaneFormation()
                } label: {
                    Text("SEND \(airshowModel.aircraftSelected.name)")
                }.padding(5)
                
                Button{
                    hideControls.toggle()
                } label: {
                    Text("SHOW CONTROLS")
                }.padding(5)
                
                Button{
                    viewModel.currentView = .mainMenu
                    
                    
                    #if os(visionOS)
                    Task { await dismissImmersiveSpace()}
                    #endif
                    
                    
                } label: {
                    Text("EXIT")
                }.padding(5)
            }
        }
    }
    
    func initView(){
        
        if airshowModel.speed > 343 {
            superSonic = true
        } else {
            superSonic = false
        }
        
        if airshowModel.speed < 100 && convertMPHToMetersPerSecond(miles: airshowModel.aircraftSelected.topSpeed) >= 100 {
            
            airshowModel.speed = 100
            
            
        }
        
        if airshowModel.speed > convertMPHToMetersPerSecond(miles: airshowModel.aircraftSelected.topSpeed){
            airshowModel.speed = convertMPHToMetersPerSecond(miles: airshowModel.aircraftSelected.topSpeed)
        }
        
        
    }
}

struct AircraftSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSettingsView()
    }
}

#endif

func convertMPHToMetersPerSecond(miles: Int) -> Float {
    let miles = Float(miles)
    return miles * 0.44704
}

func convertMetersPerSecondToMPH(meterPerSecond: Float) -> Float {
    return meterPerSecond * 2.23694
}

func convertMetersPerSecondToKPH(meterPerSecond: Float) -> Float {
    return meterPerSecond * 3.6
}


func adjustStartingDistance(topSpeed: Int, height: Float) -> Float {
    
    
    
 
    
    
    if topSpeed > 1000 && height > 500 {
        return -3000
    }
    else if topSpeed > 1000 || (topSpeed > 600 && height >= 500){
        return -2500
    } else if topSpeed > 600 {
        return -2000
    } else {
        return -1500
    }
    
}
