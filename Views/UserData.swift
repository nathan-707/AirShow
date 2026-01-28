//
//  UserData.swift
//  AirShow
//
//  Created by Nathan Eriksen on 11/9/24.
//

import Foundation
import SwiftData






// default settings:
let defaultSettings = DataModel(userUnitsMPH: true)

@Model
class DataModel {
    
    var userUnitsMPH: Bool
    
    init(userUnitsMPH: Bool ){
        self.userUnitsMPH = true
    }
}






