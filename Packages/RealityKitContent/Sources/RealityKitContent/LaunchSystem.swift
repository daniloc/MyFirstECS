//
//  File.swift
//
//
//  Created by Danilo Campos on 4/1/24.
//

import RealityKit
import Foundation

public class LaunchSystem: System {
    
    private static let query = EntityQuery(where: .has(LaunchComponent.self))
    
    // Initializer is required. Use an empty implementation if there's no setup needed.
    public required init(scene: Scene) { }
    
    // Iterate through all entities containing a LaunchComponent:
    public func update(context: SceneUpdateContext) {
        
        context.scene.performQuery(Self.query).forEach { launchableEntity in
            
            guard var launchComponent = launchableEntity.components[LaunchComponent.self],
                  let model = launchableEntity.findModelEntity()
            else {
                return
            }
            
            if launchComponent.launchInitiated == true,
               launchComponent.timeLaunched == 0 {
                
                //^ Only launch if we don't have a timestamp and the entity has been marked for launch
                
                launch(model, parent: launchableEntity, launchComponent: launchComponent)
                
            }
            
            //If it's been more than three seconds since launch, return the rocket and reset:
            
            else if launchComponent.timeLaunched.intervalToNow > 3 {
                
                
                launchComponent.timeLaunched = 0
                launchComponent.launchInitiated = false
                
                model.position = .zero
                model.clearForcesAndTorques()
                model.resetPhysicsTransform()
                model.physicsBody = nil //Despite the above, fully reseting physics requires moving the physicsBody. Please PR if you find a better approach.
                
                launchableEntity.components.set(launchComponent)
                
            }
        }
    }
    
    /// Configure and launch a model entity, updating its components as needed
    /// - Parameters:
    ///   - model: A model entity
    ///   - parent: The model's root entity, which has a LaunchComponent attached
    ///   - launchComponent: A launch component
    func launch(_ model: ModelEntity, parent: Entity, launchComponent: LaunchComponent) {
        
        if model.collision == nil {
            
            //Adding force requires a collision component
            //https://developer.apple.com/documentation/realitykit/collisioncomponent
            
            let collision = CollisionComponent(shapes: [.generateBox(size: .init(repeating: 0.1))])
            model.collision = collision
        }
        
        if model.physicsBody == nil {
            
            //Adding force requires a physics body
            //https://developer.apple.com/documentation/realitykit/physicsbodycomponent
            
            var physics = PhysicsBodyComponent()
            physics.isAffectedByGravity = false
            physics.massProperties.mass = 0.1
            model.physicsBody = physics
            
        }
        
        let thrustForce = SIMD3<Float>(0, launchComponent.thrustForce * 10, 0)
        model.addForce(thrustForce, relativeTo: nil)
        
        //Update the component and re-attach it to the parent
        var launchComponent = launchComponent
        launchComponent.timeLaunched = Date.nowToDouble()
        parent.components[LaunchComponent.self]?.timeLaunched = Date.nowToDouble()
    }
}
