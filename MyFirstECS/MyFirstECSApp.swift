//
//  MyFirstECSApp.swift
//  MyFirstECS
//
//  Created by Danilo Campos on 4/1/24.
//

import SwiftUI
import RealityKitContent

@main
struct MyFirstECSApp: App {
    
    init() {
        
        //Components and systems must be registered:
        
        LaunchComponent.registerComponent()
        LaunchSystem.registerSystem()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
    }
}
