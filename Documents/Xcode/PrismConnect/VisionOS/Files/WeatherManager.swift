////
////  WeatherManager.swift
////  Prism Connect
////
////  Created by Nathan Eriksen on 4/9/25.
////
//
import Foundation
import RealityKit



enum WeatherLight: Int {
  case CLEAR_DAY,
  CLEAR_NIGHT,
  CLOUDS_DAY,
  CLOUDS_NIGHT,
  RAIN,
  DRIZZLE,
  THUNDERSTORM,
  SNOW,
  TORNADO,
  DUST,
  MIST,
  SMOKE
    
    static func from(_ rawValue: Int) -> WeatherLight? {
          return WeatherLight(rawValue: rawValue)
      }
    
    
};


struct WeatherManager {
    var clock: Entity
    var weatherTransitionPoof: Entity
    var timeEntity: Entity
    var screenBlock: Entity
    var sun: Entity
    var clouds: Entity
    var rain: Entity
    var dark_Clouds: Entity
    var moon: Entity
    var drizzle: Entity
    var clouds_fullRoom: Entity
    
    init(scene: Entity, weather: WeatherLight, hour: Int, min: Int, wholeRoom: Bool){
        self.clock = scene.findEntity(named: "Clock")!
        self.clouds = scene.findEntity(named: "CLOUDS")!
        self.sun = scene.findEntity(named: "SUN")!
        self.weatherTransitionPoof = scene.findEntity(named: "weatherTransitionPoof")!
        self.rain = scene.findEntity(named: "RAIN")!
        self.dark_Clouds = scene.findEntity(named: "DARK_CLOUDS")!
        self.moon = scene.findEntity(named: "MOON")!
        self.drizzle = scene.findEntity(named: "DRIZZLE")!
        self.screenBlock = scene.findEntity(named: "ScreenBlock")!
        self.clouds_fullRoom = scene.findEntity(named: "CLOUDS_1")!
        self.timeEntity = ModelEntity(mesh: .generateText("spank me"), materials: [UnlitMaterial(color: .green)])
        self.updateWeather(weatherUpdate: weather, wholeRoom: wholeRoom)
        self.updateTime(hour: String(hour), min: String(min))
    }

    mutating func updateTime(hour: String, min: String){
        timeEntity.removeFromParent()
        self.timeEntity = ModelEntity(mesh: .generateText(hour + ":" + min), materials: [UnlitMaterial(color: .green)])
        timeEntity.scale = [0.005,0.005,0.005]
        timeEntity.position.x += 0.0
        timeEntity.position.y += 0
        timeEntity.position.z += 0.05
        self.clock.addChild(timeEntity)
    }
    
    func updateWeather(weatherUpdate: WeatherLight, wholeRoom: Bool){
        for child in clock.children {
            if child != timeEntity && child != screenBlock{
                clock.removeChild(child)
            }
        }
        
        clock.addChild(weatherTransitionPoof)
        
        switch weatherUpdate {
        case .CLEAR_DAY:
            clock.addChild(self.sun.clone(recursive: true))
        case .CLEAR_NIGHT:
            clock.addChild(self.moon.clone(recursive: true))
            break
        case .CLOUDS_DAY:
            clock.addChild(self.clouds.clone(recursive: true))
            clock.addChild(self.sun.clone(recursive: true))
        case .CLOUDS_NIGHT:
            clock.addChild(self.clouds.clone(recursive: true))
            clock.addChild(self.moon.clone(recursive: true))
            break
        case .RAIN:
            clock.addChild(self.rain.clone(recursive: true))
            clock.addChild(self.dark_Clouds.clone(recursive: true))
            break
        case .DRIZZLE:
            clock.addChild(self.drizzle.clone(recursive: true))
            clock.addChild(self.dark_Clouds.clone(recursive: true))
            break
        case .THUNDERSTORM:
            clock.addChild(self.dark_Clouds.clone(recursive: true))
            clock.addChild(self.rain.clone(recursive: true))
            break
        case .SNOW:
            // add here
            break
        case .TORNADO:
            // add here
            break
        case .DUST:
            // add here
            break
        case .MIST:
            // add here
            break
        case .SMOKE:
            // add here
            break
        }
        
        if wholeRoom {
            switch weatherUpdate {
            case .CLEAR_DAY:
                break
            case .CLEAR_NIGHT:
                break
            case .CLOUDS_DAY:
                
                self.clock.addChild(self.clouds_fullRoom.clone(recursive: true))
                break
            case .CLOUDS_NIGHT:
                break
            case .RAIN:
                break
            case .DRIZZLE:
                break
            case .THUNDERSTORM:
                break
            case .SNOW:
                break
            case .TORNADO:
                break
            case .DUST:
                break
            case .MIST:
                break
            case .SMOKE:
                break
            }
        }
    }
}

