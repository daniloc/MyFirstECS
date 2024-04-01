//
//  ContentView.swift
//  MyFirstECS
//
//  Created by Danilo Campos on 4/1/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false
    @State var sceneRoot: Entity?

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    
                    content.add(scene) //Insert the RCP file as an entity
                    
                    // Nudge the whole scene down a bit:
                    scene.setPosition([0, -0.25, 0], relativeTo: nil)
                    scene.setSunlight(intensity: 12)
                    
                    self.sceneRoot = scene //Store the scene for later querying
                    
                }
            } update: { content in
            }

            //Simple SwiftUI view to control launch:
            
            VStack {
                Button(action: {
                    launch()
                }, label: {
                    Text("Initiate Launch")
                })
            }.padding().glassBackgroundEffect()
        }
    }
    
    /// Find all launchable entities and set their components to initiate launch
    func launch() {
        
        
        let launchableEntities = sceneRoot?.findEntitiesWithComponent(LaunchComponent.self)
        //Note this recursive find function is defined in the RealityKitContent ConvenienceExtensions file and has not been performance profiled. A production application may way to find more direct ways to grab the relevant entities.
        
        launchableEntities?.forEach { entity in
            guard var component = entity.components[LaunchComponent.self] else {
                return
            }
            
            component.launchInitiated = true
            
            entity.components.set(component)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
