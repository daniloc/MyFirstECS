//
//  File.swift
//
//
//  Created by Danilo Campos on 4/1/24.
//

import Foundation
import RealityKit

public extension Entity {
    
    
    /// Recursively searches the entity and its children for a `ModelEntity` which can have physics applied to it.
    /// - Returns: The first `ModelEntity` discovered from descedents of an `Entity` instance.
    func findModelEntity() -> ModelEntity? {
        if let modelEntity = self as? ModelEntity {
            return modelEntity
        }
        
        // Recursively search in the children
        for child in self.children {
            if let found = child.findModelEntity() {
                return found
            }
        }
        
        // Return nil if no ModelEntity with a collision component is found in the hierarchy
        print("Could not find collisionable entity for \(self)")
        return nil
    }
    
    /// Recursively searches the entity and its children for all entities with a given component type. **Don't use this in systems; instead, query the scene update context.** This is provided for convenience at the UI level.
    /// - Parameter componentType: A component type.
    /// - Returns: All entities which have the component.
    func findEntitiesWithComponent<T: Component>(_ componentType: T.Type) -> [Entity] {
        var entitiesWithComponent: [Entity] = []

        // Check if the current entity has the component and add it to the array
        if self.components[componentType] != nil {
            entitiesWithComponent.append(self)
        }

        // Recursively search in the child entities
        for child in self.children {
            entitiesWithComponent.append(contentsOf: child.findEntitiesWithComponent(componentType))
        }

        return entitiesWithComponent
    }
}

//Using Date objects directly in components gives me trouble, so I've defined these extensions on Date and Double to work around this. If there's a better way, please open a pull request!

extension Double {
    var toDate: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var intervalToNow: TimeInterval {
        return Date.now.timeIntervalSince(self.toDate)
    }
}

extension Date {
    var toDouble: Double {
        return self.timeIntervalSince1970
    }
    
    static func nowToDouble() -> Double {
        return Self.now.timeIntervalSince1970
    }
}
