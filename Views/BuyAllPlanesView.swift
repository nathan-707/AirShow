//
//  BuyAllPlanesView.swift
//  AirShow
//
//  Created by Nathan Eriksen on 3/2/24.
//

import SwiftUI
import StoreKit


struct BuyAllPlanesView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        
        ProductView(id: buyAllPlaneInAppPurchaseID)
        
        VStack {
            Button {
                viewModel.currentView = .mainMenu
            } label: {
                Text("Exit")
            }
        }
    }
}

#Preview {
    BuyAllPlanesView()
}
