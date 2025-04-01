/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 A large sphere that has an image of the night sky on its inner surface.
 */

import SwiftUI
import RealityKit

/// A large sphere that has an image of the night sky on its inner surface.
///
/// When centered on the viewer, this entity creates the illusion of floating
/// in space.

enum FullSpaceSetting: String, CaseIterable, Identifiable {
    case  none, daytime, ocean, test1, test2,
          starsNight, sunsetQuarry, test4, test5
    
    var id: Self { self }
}

let whatToTest = "test5"

struct BackGroundView: View {
    
    @EnvironmentObject private var viewModel: theViewModel
    @State var nameOfResource = ""
    
    @State var radiusOfBackground: Float = 90000
    
    
    let backGroundOrgin = Entity()
    @State var backgroundYoffset: Float = 0
    @State var backgroundRotation: Float = 0
    
    var body: some View {
        
        RealityView { content in
            
            switch viewModel.selectedEnvironment {
                
            case .daytime:
                nameOfResource = "daytime"
            case .test1:
                nameOfResource = "test1"
                backgroundRotation = 41
            case .test2:
                nameOfResource = "test2"
                backgroundRotation = 40
                backgroundYoffset = -500
                
            case .ocean:
                nameOfResource = "ocean"
                
                
            case .starsNight:
                nameOfResource = "starsNight"
                backgroundRotation = 10
                
                
            case .sunsetQuarry:
                nameOfResource = "sunsetQuarry"
                backgroundRotation = 100
                
                
            case .test4: // city
                nameOfResource = "test4"
                backgroundRotation = -90
                
            case .test5: // cornfield
                nameOfResource = "test5"
            default:
                break
            }
            
            if viewModel.selectedEnvironment != .none {
                
                
                guard let resource = try? await TextureResource.init(named: nameOfResource) else { // testing
                    
                    //  guard let resource = try? TextureResource.load(named: nameOfResource) else { // :: old
                    // If the asset isn't available, something is wrong with the app.
                    fatalError("Unable to load starfield texture.")
                }
                
                var material = UnlitMaterial()
                material.color = .init(texture: .init(resource))
                
                // Attach the material to a large sphere.
                let entity = Entity()
                
                
                entity.components.set(ModelComponent(
                    mesh: .generateSphere(radius: radiusOfBackground),
                    materials: [material]
                ))
                
                // Ensure the texture image points inward at the viewer.
                entity.scale *= .init(x: -1, y: 1, z: 1)
                
                entity.components.set(PhysicsBodyComponent(shapes: [.generateBox(size: SIMD3<Float>(0,0,0))], mass: 0, material: .default, mode: .kinematic))
                
                if backgroundRotation != 0 {
                    entity.transform.rotation = simd_quatf(angle: backgroundRotation, axis: SIMD3<Float>(0,1,0))
                }
                
                backGroundOrgin.addChild(entity)
                backGroundOrgin.position = SIMD3(0,backgroundYoffset,0)
                content.add(backGroundOrgin)
                
            }
        }
    }
}



