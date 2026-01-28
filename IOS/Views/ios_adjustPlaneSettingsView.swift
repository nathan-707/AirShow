//
//  ios_adjustPlaneSettingsView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 10/26/25.
//

import SwiftUI

#if os(iOS)

    let minSpeed: Float = 20

    struct ios_adjustPlaneSettingsView: View {

        @EnvironmentObject private var viewModel: theViewModel
        @EnvironmentObject private var airshowModel: theAirShowModel
        @State var superSonic = false

        @State var hideControls = false
        @State var topSpeed: Float = minSpeed + 3

        var body: some View {

            if hideControls == false {

                VStack {

                    Spacer()

                    HStack {

                        Button {
                            airshowModel.spawnPlaneFormation()
                        } label: {
                            Text("SEND \(airshowModel.aircraftSelected.name)")

                        }

                        HStack {
                            Picker("", selection: $airshowModel.formation) {
                                Text("SINGLE").tag(1)
                                Text("TRIO").tag(2)
                                Text("LARGE").tag(3)
                            }
                        }
                    }

                    HStack {
                        Text("ALTITUDE:")

                        Slider(value: $airshowModel.height, in: -10...1000) {}

                        if viewModel.userUnits == .milePerHour {
                            Text("\(Int(airshowModel.height * 3.28084)) FEET")

                        } else {
                            Text("\(Int(airshowModel.height)) METERS")

                        }
                    }

                    HStack {
                        Text("SPEED:")
                        Slider(
                            value: $airshowModel.speed,
                            in: minSpeed...topSpeed
                        )
                        .onChange(of: airshowModel.speed) {

                            oldValue,
                            newValue in
                            if newValue > 343 {
                                superSonic = true
                            } else {
                                superSonic = false
                            }
                        }

                        if viewModel.userUnits == .milePerHour {
                            Text(
                                "\(Int(convertMetersPerSecondToMPH(meterPerSecond: airshowModel.speed))) MPH"
                            )

                        } else {
                            Text(
                                "\(Int(convertMetersPerSecondToKPH(meterPerSecond: airshowModel.speed))) KPH"
                            )
                        }
                    }

                    HStack {

                        VStack {

                            if superSonic {
                                Text("(SUPERSONIC)")
                            }

                            if airshowModel.speed
                                >= convertMPHToMetersPerSecond(
                                    miles: airshowModel.aircraftSelected
                                        .topSpeed - 3
                                )
                            {

                                Text(
                                    "\(airshowModel.aircraftSelected.name) MAX SPEED"
                                )

                            }
                        }
                    }

                    HStack {

                        Button {
                            hideControls.toggle()
                        } label: {
                            Text("HIDE CONTROLS").bold().foregroundStyle(
                                .orange
                            )
                        }

                        Button {
                            viewModel.currentView = .mainMenu

                        } label: {
                            Text("EXIT").foregroundColor(
                                .orange
                            )

                        }
                    }
                }
                .onAppear {
                    topSpeed = convertMPHToMetersPerSecond(
                        miles: airshowModel.aircraftSelected.topSpeed
                    )
                    initView()
                }
            } else {

                VStack {
                    Button {
                        airshowModel.spawnPlaneFormation()
                    } label: {
                        Text("SEND \(airshowModel.aircraftSelected.name)")
                    }

                    Button {
                        hideControls.toggle()
                    } label: {
                        Text("SHOW CONTROLS")
                    }

                }
            }
        }

        func initView() {

            if airshowModel.speed > 343 {
                superSonic = true
            } else {
                superSonic = false
            }

            if airshowModel.speed < 100
                && convertMPHToMetersPerSecond(
                    miles: airshowModel.aircraftSelected.topSpeed
                ) >= 100
            {

                airshowModel.speed = 100

            }

            if airshowModel.speed
                > convertMPHToMetersPerSecond(
                    miles: airshowModel.aircraftSelected.topSpeed
                )
            {
                airshowModel.speed = convertMPHToMetersPerSecond(
                    miles: airshowModel.aircraftSelected.topSpeed
                )
            }

        }
    }

#endif
