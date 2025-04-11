//
//  TeleportCities.swift
//  Prism Connect
//
//  Created by Nathan Eriksen on 3/5/25.
//

import Foundation


func returnCityFromID(ID: Int) -> City {
    for city in ALL_CITIES {
        if city.id == ID {
            return city
        }
    }
    
    return ALL_CITIES[0]

}

struct City: Identifiable, Hashable {
    var id: Int
    var city: String
    var territory: String
    
    func nameForPicker() -> String {
        if self == worldTourCity  {
            return "World Tour - Cycle Through All"
        } else if self == randomLocationCity {
            return "Random Location"
        }
        
        return self.city + ", " + self.territory
    }
}


let worldTour = 149
let randomLocation = 148
let randomLocationCity = City(id: randomLocation, city: "Random Location", territory: "")
let worldTourCity = City(id: worldTour, city: "World Tour", territory: "(Cycle Through All)")


let CityModes: [City] = [
    worldTourCity, randomLocationCity
]

let US_CITIES: [City] = [
    City(id: 0, city: "Birmingham", territory: "Alabama"),
    City(id: 1, city: "Anchorage", territory: "Alaska"),
    City(id: 2, city: "Utqiaġvik", territory: "Alaska"),
    City(id: 3, city: "Phoenix", territory: "Arizona"),
    City(id: 4, city: "Little Rock", territory: "Arkansas"),
    City(id: 5, city: "Anaheim", territory: "California"),
    City(id: 6, city: "Death Valley", territory: "California"),
    City(id: 7, city: "Hollywood", territory: "California"),
    City(id: 8, city: "San Diego", territory: "California"),
    City(id: 9, city: "Denver", territory: "Colorado"),
    City(id: 10, city: "Bridgeport", territory: "Connecticut"),
    City(id: 11, city: "Wilmington", territory: "Delaware"),
    City(id: 12, city: "Bay Lake", territory: "Florida"),
    City(id: 13, city: "Key West", territory: "Florida"),
    City(id: 14, city: "Orlando", territory: "Florida"),
    City(id: 15, city: "Miami", territory: "Florida"),
    City(id: 16, city: "Atlanta", territory: "Georgia"),
    City(id: 17, city: "Honolulu", territory: "Hawaii"),
    City(id: 18, city: "Boise", territory: "Idaho"),
    City(id: 19, city: "Chicago", territory: "Illinois"),
    City(id: 20, city: "Indianapolis", territory: "Indiana"),
    City(id: 21, city: "Des Moines", territory: "Iowa"),
    City(id: 22, city: "Wichita", territory: "Kansas"),
    City(id: 23, city: "Louisville", territory: "Kentucky"),
    City(id: 24, city: "Elizabethtown", territory: "Kentucky"),
    City(id: 25, city: "New Orleans", territory: "Louisiana"),
    City(id: 26, city: "Portland", territory: "Maine"),
    City(id: 27, city: "Baltimore", territory: "Maryland"),
    City(id: 28, city: "Boston", territory: "Massachusetts"),
    City(id: 29, city: "Detroit", territory: "Michigan"),
    City(id: 30, city: "Minneapolis", territory: "Minnesota"),
    City(id: 31, city: "Jackson", territory: "Mississippi"),
    City(id: 32, city: "Kansas City", territory: "Missouri"),
    City(id: 33, city: "Saint Louis", territory: "Missouri"),
    City(id: 34, city: "Billings", territory: "Montana"),
    City(id: 35, city: "Omaha", territory: "Nebraska"),
    City(id: 36, city: "Las Vegas", territory: "Nevada"),
    City(id: 37, city: "Dover", territory: "New Hampshire"),
    City(id: 38, city: "Newark", territory: "New Jersey"),
    City(id: 39, city: "Albuquerque", territory: "New Mexico"),
    City(id: 40, city: "New York", territory: "New York"),
    City(id: 41, city: "Charlotte", territory: "North Carolina"),
    City(id: 42, city: "Morehead City", territory: "North Carolina"),
    City(id: 43, city: "Fargo", territory: "North Dakota"),
    City(id: 44, city: "Mason", territory: "Ohio"),
    City(id: 45, city: "Oklahoma City", territory: "Oklahoma"),
    City(id: 46, city: "Portland", territory: "Oregon"),
    City(id: 47, city: "Philadelphia", territory: "Pennsylvania"),
    City(id: 48, city: "Providence", territory: "Rhode Island"),
    City(id: 49, city: "Charleston", territory: "South Carolina"),
    City(id: 50, city: "Sioux Falls", territory: "South Dakota"),
    City(id: 51, city: "Pigeon Forge", territory: "Tennessee"),
    City(id: 52, city: "Nashville", territory: "Tennessee"),
    City(id: 53, city: "Houston", territory: "Texas"),
    City(id: 54, city: "Salt Lake City", territory: "Utah"),
    City(id: 55, city: "Burlington", territory: "Vermont"),
    City(id: 56, city: "Virginia Beach", territory: "Virginia"),
    City(id: 57, city: "Seattle", territory: "Washington"),
    City(id: 58, city: "Charleston", territory: "West Virginia"),
    City(id: 59, city: "Milwaukee", territory: "Wisconsin"),
    City(id: 60, city: "Cheyenne", territory: "Wyoming"),
]

let WORLD_CITIES: [City] = [
    City(id: 61, city: "Kabul", territory: "Afghanistan"),
    City(id: 62, city: "McMurdo", territory: "Antarctica"),
    City(id: 63, city: "Buenos Aires", territory: "Argentina"),
    City(id: 64, city: "Queensland", territory: "Australia"),
    City(id: 65, city: "Vienna", territory: "Austria"),
    City(id: 66, city: "Brussels", territory: "Belgium"),
    City(id: 67, city: "Sao Paulo", territory: "Brazil"),
    City(id: 68, city: "Rio de Janeiro", territory: "Brazil"),
    City(id: 69, city: "Siem Reap", territory: "Cambodia"),
    City(id: 70, city: "Alert", territory: "Canada"),
    City(id: 71, city: "Toronto", territory: "Canada"),
    City(id: 72, city: "Cartagena", territory: "Colombia"),
    City(id: 73, city: "West Bay", territory: "Cayman Islands"),
    City(id: 74, city: "Santiago", territory: "Chile"),
    City(id: 75, city: "Beijing", territory: "China"),
    City(id: 76, city: "Shanghai", territory: "China"),
    City(id: 77, city: "Brazzaville", territory: "Congo"),
    City(id: 78, city: "San Jose", territory: "Costa Rica"),
    City(id: 79, city: "Havana", territory: "Cuba"),
    City(id: 80, city: "Copenhagen", territory: "Denmark"),
    City(id: 81, city: "Quito", territory: "Ecuador"),
    City(id: 82, city: "Cairo", territory: "Egypt"),
    City(id: 83, city: "Helsinki", territory: "Finland"),
    City(id: 84, city: "Bora Bora", territory: "French Polynesia"),
    City(id: 85, city: "Paris", territory: "France"),
    City(id: 86, city: "Berlin", territory: "Germany"),
    City(id: 87, city: "Athens", territory: "Greece"),
    City(id: 88, city: "Nuuk", territory: "Greenland"),
    City(id: 89, city: "Hong Kong", territory: "Hong Kong"),
    City(id: 90, city: "Budapest", territory: "Hungary"),
    City(id: 91, city: "Reykjavik", territory: "Iceland"),
    City(id: 92, city: "Mawsynram", territory: "India"),
    City(id: 93, city: "Mumbai", territory: "India"),
    City(id: 94, city: "Sanandaj", territory: "Iran"),
    City(id: 95, city: "Baghdad", territory: "Iraq"),
    City(id: 96, city: "Dublin", territory: "Ireland"),
    City(id: 97, city: "Milan", territory: "Italy"),
    City(id: 98, city: "Kingston", territory: "Jamaica"),
    City(id: 99, city: "Aomori", territory: "Japan"),
    City(id: 100, city: "Hiroshima", territory: "Japan"),
    City(id: 101, city: "Nagasaki", territory: "Japan"),
    City(id: 102, city: "Osaka", territory: "Japan"),
    City(id: 103, city: "Tokyo", territory: "Japan"),
    City(id: 104, city: "Petra", territory: "Jordan"),
    City(id: 105, city: "Kuwait City", territory: "Kuwait"),
    City(id: 106, city: "Antananarivo", territory: "Madagascar"),
    City(id: 107, city: "Colima", territory: "Mexico"),
    City(id: 108, city: "Mexico City", territory: "Mexico"),
    City(id: 109, city: "Ulaanbaatar", territory: "Mongolia"),
    City(id: 110, city: "Casablanca", territory: "Morocco"),
    City(id: 111, city: "Kathmandu", territory: "Nepal"),
    City(id: 112, city: "Amsterdam", territory: "Netherlands"),
    City(id: 113, city: "Auckland", territory: "New Zealand"),
    City(id: 114, city: "Niamey", territory: "Niger"),
    City(id: 115, city: "Pyongyang", territory: "North Korea"),
    City(id: 116, city: "Örebro", territory: "Sweden"),
    City(id: 117, city: "Oslo", territory: "Norway"),
    City(id: 118, city: "Karachi", territory: "Pakistan"),
    City(id: 119, city: "Panama City", territory: "Panama"),
    City(id: 120, city: "Lima", territory: "Peru"),
    City(id: 121, city: "Davao", territory: "Philippines"),
    City(id: 122, city: "Warsaw", territory: "Poland"),
    City(id: 123, city: "Lisbon", territory: "Portugal"),
    City(id: 124, city: "Moscow", territory: "Russia"),
    City(id: 125, city: "Oymyakon", territory: "Russia"),
    City(id: 126, city: "Yakutsk", territory: "Russia"),
    City(id: 127, city: "Mecca", territory: "Saudi Arabia"),
    City(id: 128, city: "Riyadh", territory: "Saudi Arabia"),
    City(id: 129, city: "Edinburgh", territory: "Scotland"),
    City(id: 130, city: "Singapore", territory: "Singapore"),
    City(id: 131, city: "Madrid", territory: "Spain"),
    City(id: 132, city: "Tarragona", territory: "Spain"),
    City(id: 133, city: "Suva", territory: "Fiji"),
    City(id: 134, city: "Aleppo", territory: "Syria"),
    City(id: 135, city: "Andong", territory: "South Korea"),
    City(id: 136, city: "Johannesburg", territory: "South Africa"),
    City(id: 137, city: "Zurich", territory: "Switzerland"),
    City(id: 138, city: "Taipei", territory: "Taiwan"),
    City(id: 139, city: "Rayong", territory: "Thailand"),
    City(id: 140, city: "Istanbul", territory: "Turkey"),
    City(id: 141, city: "Kampala", territory: "Uganda"),
    City(id: 142, city: "Kyiv", territory: "Ukraine"),
    City(id: 143, city: "Dubai", territory: "United Arab Emirates"),
    City(id: 144, city: "London", territory: "United Kingdom"),
    City(id: 145, city: "Sana'a", territory: "Yemen"),
    City(id: 146, city: "Harare", territory: "Zimbabwe"),
    
   
]


let ALL_CITIES: [City] = CityModes + US_CITIES + WORLD_CITIES

