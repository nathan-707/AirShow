//
//  MainMenuView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 2/8/24.
//

import RealityKit
import RealityKitContent
import StoreKit
import SwiftData
import SwiftUI


#if os(visionOS)

    struct MainMenuView: View {

        @Environment(\.modelContext) var modelContext
        @Query var dataModelQuery: [DataModel]

        @Environment(\.purchase) private var purchaseAction
        @Environment(\.openWindow) private var openWindow

        @Environment(\.openImmersiveSpace) private var openImmersiveSpace

        @EnvironmentObject var viewModel: ViewModel
        @EnvironmentObject var airshowModel: theAirShowModel
        @EnvironmentObject var storeModel: Store

        @State var showPurchaseScreen = false

        var body: some View {

            VStack {

                NavigationSplitView {

                    List {

                        ForEach(getFilter(viewModel: viewModel)) { aircraft in
                            Button {
                                airshowModel.aircraftSelected = aircraft
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

                    }.navigationTitle("Aircrafts").foregroundColor(.white)

                } detail: {

                    VStack {

                        Rectangle().frame(width: 9000, height: 2).opacity(0.4)
                            .foregroundColor(.green)

                        HStack {
                            ScrollView(.horizontal) {

                                HStack {
                                    EntryCapsule(
                                        topic: " ORIGIN ",
                                        info: printOrigin(
                                            origin: airshowModel
                                                .aircraftSelected.origin
                                        )
                                    )
                                    Rectangle().frame(width: 1, height: 130)
                                        .opacity(0.4)
                                    EntryCapsule(
                                        topic: "MANUFACTURER",
                                        info: airshowModel.aircraftSelected
                                            .Manufacturer
                                    )
                                    Rectangle().frame(width: 1, height: 130)
                                        .opacity(0.4)
                                    EntryCapsule(
                                        topic: " STATUS ",
                                        info: printAircraftStatus(
                                            status: airshowModel
                                                .aircraftSelected.status
                                        )
                                    )
                                    Rectangle().frame(width: 1, height: 130)
                                        .opacity(0.4)

                                    if viewModel.userUnits == .milePerHour {
                                        EntryCapsule(
                                            topic: "MAX SPEED",
                                            info: String(
                                                airshowModel.aircraftSelected
                                                    .topSpeed
                                            ) + " MPH",
                                            KM: mphToKmh(
                                                mph: airshowModel
                                                    .aircraftSelected.topSpeed
                                            )
                                        )

                                    } else {
                                        EntryCapsule(
                                            topic: "MAX SPEED",
                                            info: String(
                                                mphToKmh(
                                                    mph: airshowModel
                                                        .aircraftSelected
                                                        .topSpeed
                                                )
                                            ) + " KPH",
                                            KM: mphToKmh(
                                                mph: airshowModel
                                                    .aircraftSelected.topSpeed
                                            )
                                        )
                                    }

                                    Rectangle().frame(width: 1, height: 130)
                                        .opacity(0.4)
                                }
                            }

                            AircraftVolume().frame(width: 150, height: 150)

                        }

                        Rectangle().frame(width: 9000, height: 2).opacity(0.4)
                            .foregroundColor(.green)

                        if userPurchasedAllAircrafts() {
                            ScrollView {
                                Text(
                                    String(
                                        airshowModel.aircraftSelected
                                            .description
                                    )
                                )
                            }.padding(.bottom)
                        } else {
                            VStack {

                                Text(
                                    "Unlock All Aircrafts to View the \(airshowModel.aircraftSelected.name) and Enter it in Custom Airshows"
                                ).font(.title).bold().padding(50)
                                    .foregroundColor(.secondary)
                                Spacer()

                            }
                        }
                    }
                    .navigationTitle(
                        airshowModel.aircraftSelected.name
                            + String(
                                " (\(airshowModel.aircraftSelected.yearIntroduced))"
                            )
                    )
                    .padding()

                }

                if userPurchasedAllAircrafts() {

                    if airshowModel.aircraftSelected.needToPurchase == true
                        && storeModel.upgraded == true
                    {
                        Text("- PURCHASED -").foregroundStyle(.secondary).font(
                            .headline
                        ).padding(.top, 5)
                    }

                    HStack {

                        Text("Sort:").font(.largeTitle).bold()

                        Picker("pick filter", selection: $viewModel.filter) {
                            Text("Accending Year").tag(sortEnum.accending)
                            Text("Descending Year").tag(sortEnum.decending)
                            Text("Max Speed").tag(sortEnum.speed)
                            if !storeModel.upgraded {
                                Text("Free Aircrafts First").tag(sortEnum.free)
                            }

                        }.padding(.trailing, 15)

                        PickEnvironment().padding(.trailing, 150)

                        Text("Units:").font(.largeTitle).bold()

                        HStack {

                            Picker(
                                "pick units",
                                selection: $viewModel.userUnits
                            ) {
                                Text("Imperial").tag(units.milePerHour)
                                Text("Metric").tag(units.kilometersPerHour)
                            }.onChange(
                                of: viewModel.userUnits,
                                { oldValue, newValue in
                                    saveSettings()
                                }
                            )

                        }.padding(.trailing, 15)

                    }

                    HStack {

                        if !storeModel.upgraded {

                            Button {
                                Task {
                                    //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                    //Call this function only in response to an explicit user action, such as tapping a button.
                                    try? await AppStore.sync()
                                    print("hey")
                                }
                            } label: {
                                Text("Restore").font(.caption).bold()
                            }

                            Button {
                                showPurchaseScreen = true
                            } label: {
                                Text("Unlock All").padding().foregroundColor(
                                    .green
                                ).bold().font(.largeTitle)
                            }.padding(.trailing)

                            Spacer()
                        }

                        Button {
                            viewModel.currentView = .adjustAircraftView
                            Task {

                                let result = await openImmersiveSpace(
                                    id: "airshowspace"
                                )

                                switch result {
                                case .opened:
                                    break
                                case .userCancelled:
                                    viewModel.currentView = .mainMenu
                                    break
                                case .error:
                                    viewModel.currentView = .mainMenu
                                    break
                                @unknown default:
                                    break
                                }
                            }
                        } label: {
                            Text("View \(airshowModel.aircraftSelected.name)")
                                .font(.extraLargeTitle2).foregroundColor(
                                    .orange
                                ).padding()
                        }.padding()

                        Button {
                            viewModel.currentView = .customAirshowView
                        } label: {
                            ZStack {
                                Rectangle().frame(width: 150, height: 85)
                                    .foregroundColor(.clear)
                                Text("Create Custom Airshow").font(
                                    .extraLargeTitle2
                                ).foregroundColor(.orange)
                            }
                        }.padding()

                        if !storeModel.upgraded {
                            Spacer()
                        }
                    }
                } else {

                    VStack {
                        Button {
                            showPurchaseScreen = true
                        } label: {
                            Text("Unlock All").padding().foregroundColor(.green)
                                .bold().font(.largeTitle)
                        }.padding()

                        Button {
                            Task {
                                try? await AppStore.sync()  // restore purchases.
                            }
                        } label: {
                            Text("Restore")
                        }.padding()

                        Text("").padding(.top, 100)
                    }
                }

                Spacer()

            }.onChange(of: storeModel.upgraded) { oldValue, newValue in
                if viewModel.filter == .free {
                    viewModel.filter = .decending
                }
            }

            .sheet(
                isPresented: $showPurchaseScreen,
                content: {
                    VStack {
                        ProductView(id: buyAllPlaneInAppPurchaseID).padding()
                            .onInAppPurchaseCompletion { Product, Result in
                                Task {
                                    showPurchaseScreen = false
                                    await storeModel.updateCustomerProductStatus()
                                }
                            }.glassBackgroundEffect(
                                in: .rect(cornerRadius: 20),
                                displayMode: .always
                            )

                        Button {
                            showPurchaseScreen = false
                        } label: {
                            Text("CANCEL")
                        }.padding()
                    }
                }
            )

            .onAppear {

                initSettings()
                print(viewModel.currentView)
            }
        }

        func saveSettings() {

            if viewModel.userUnits == .milePerHour {
                dataModelQuery.first?.userUnitsMPH = true
            } else {
                dataModelQuery.first?.userUnitsMPH = false
            }

            do {
                try modelContext.save()
            } catch {
                print("error saving")
            }
        }

        func initSettings() {

            if dataModelQuery.isEmpty {
                print("Nothing")
                modelContext.insert(defaultSettings)
                do {
                    try modelContext.save()
                } catch {
                    print("Error initializing settings")
                }

            } else {
                print("Something")

                if dataModelQuery.first?.userUnitsMPH == true {
                    viewModel.userUnits = .milePerHour

                } else {
                    viewModel.userUnits = .kilometersPerHour
                }
            }
        }

        func userPurchasedAllAircrafts() -> Bool {
            if airshowModel.aircraftSelected.needToPurchase == false
                || storeModel.upgraded == true
            {
                return true
            } else {
                return false
            }
        }

    }

#endif

func getFilter(viewModel: ViewModel) -> [Aircraft] {

    let allAircrafts = allAircrafts.reversed()

    let sortedAircraftsAccending = allAircrafts.sorted {
        $0.yearIntroduced < $1.yearIntroduced
    }

    let sortedAircraftsDescending = allAircrafts.sorted {
        $0.yearIntroduced > $1.yearIntroduced
    }

    let sortedOnlyFree = allAircrafts.sorted { aircraft1, aircraft2 in
        aircraft1.needToPurchase == false
    }
    let sortedAircraftsBySpeed = allAircrafts.sorted {
        $0.topSpeed > $1.topSpeed
    }

    switch viewModel.filter {

    case .accending:
        return sortedAircraftsAccending
    case .decending:
        return sortedAircraftsDescending
    case .free:
        return sortedOnlyFree
    case .speed:
        return sortedAircraftsBySpeed
    }
}

func printAircraftStatus(status: status) -> String {

    switch status {
    case .active:
        return "ACTIVE"
    case .notActive:
        return "RETIRED"
    case .experimental:
        return "EXPERIMENTAL"
    case .cancelled:
        return "CANCELED"
    }
}

func printOrigin(origin: origin) -> String {
    switch origin {
    case .america:
        return "United States of America"
    case .russia:
        return "Russia"
    case .ussr:
        return "U.S.S.R"
    case .china:
        return "China"
    case .EuropeanConsortiumUKGermanyItalySpain:
        return "European Consortium (UK, Germany, Italy, Spain)"
    case .germany:
        return "Germany"
    case .uk:
        return "U.K"
    case .france:
        return "France"
    case .japan:
        return "Japan"
    case .turkey:
        return "Turkey"
    case .naziGermany:
        return "Nazi Germany"
    case .austria:
        return "Austria"
    case .sweden:
        return "Sweden"
    case .canada:
        return "Canada"
    }
}

func mphToKmh(mph: Int) -> Int {
    let doubleInt = Double(mph)
    let double = doubleInt * 1.60934
    return Int(double)
}
