//
//  ContentView.swift
//  bluetoothTest
//
//  Created by Nathan Eriksen on 6/13/24.
//

import SwiftUI
import CoreBluetooth

#if os(iOS)
import AccessorySetupKit

import CoreBluetooth


struct ContentView: View {
    
    @EnvironmentObject var prismSessionManager: ClockSessionManager
    
    var body: some View {
        if prismSessionManager.pickerDismissed && prismSessionManager.authenticated, let prismboxVersion = prismSessionManager.prismboxVersion {
            if prismSessionManager.appView == .connectedMainMenu {
                ConnectedMainMenu()
                
            }
        }
        else {
            makeSetupView
        }
    }
    
    @ViewBuilder
    private var makeSetupView: some View {
        VStack {
            Spacer()
            Image(systemName: "clock.badge.questionmark.fill")
                .font(.system(size: 150, weight: .light, design: .default))
                .foregroundStyle(.gray)
            Text("No Prism Box")
                .font(Font.title.weight(.bold))
                .padding(.vertical, 12)
            Text("Hold your iPhone near your Prism Box.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
#if os(visionOS)
                print("visiion")
                
#endif
                
                
#if os(iOS)
                prismSessionManager.presentPicker()
#endif
                
                
                
                
                
                
                
            } label: {
                Text("Add Prism Box")
                    .frame(maxWidth: .infinity)
                    .font(Font.headline.weight(.semibold))
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .foregroundStyle(.primary)
            .controlSize(.large)
            .padding(.top, 110)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(64)
    }
}
#endif
