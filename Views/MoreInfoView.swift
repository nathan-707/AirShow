//
//  MoreInfoView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 4/1/24.
//

import SwiftUI


struct MoreInfoView: View {
    
    @EnvironmentObject private var airshowModel: theAirShowModel
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack{
        ScrollView(.horizontal){
        HStack{
                
                HStack{
                    Text("MANUFACTURER: ").font(.title).bold()
                    Text(airshowModel.nowShowing.Manufacturer).font(.title)
                }.padding()
                
                HStack{
                    Text("ORIGIN: ").font(.title).bold()
                    Text(printOrigin(origin: airshowModel.nowShowing.origin)).font(.title)

                }.padding()
                
                HStack{
                    Text("YEAR: ").font(.title).bold()
                    Text(String(airshowModel.nowShowing.yearIntroduced)).font(.title)

                }.padding()
                
                
                HStack{
                    Text("STATUS: ").font(.title).bold()
                    Text(printAircraftStatus(status: airshowModel.nowShowing.status)).font(.title)
                }.padding()
                
                
                
                HStack{
                    Text("MAX SPEED: ").font(.title).bold()
                    
                    if viewModel.userUnits == .milePerHour {
                        Text(String(airshowModel.nowShowing.topSpeed)).font(.title)
                        Text(" MPH").font(.title)
                    } else {
                        Text(String( mphToKmh(mph: airshowModel.nowShowing.topSpeed)  )).font(.title)
                        Text(" KPH").font(.title)
                        
                    }
                    
                }.padding()
               
                }
            }
            
            ScrollView{
                Text(airshowModel.nowShowing.description)
            }
        }
    }
}

#Preview {
    MoreInfoView()
}
