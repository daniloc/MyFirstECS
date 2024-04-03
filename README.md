# My First ECS: A five minute intro to Entity Component System for visionOS

In learning to build for visionOS, I spent a lot of time scratching my head at the [ECS design pattern](https://developer.apple.com/documentation/visionOS/understanding-the-realitykit-modular-architecture) in RealityKit. This project is the crash course I wish I'd had.

My First ECS is a five minute dive with:

- One component
- One system
- One button
- Multiple rockets launched in the bargain:

https://github.com/daniloc/MyFirstECS/assets/213358/45dc377b-2218-48fc-8934-d62b71376cac

I have resisted the urge to add embelishment to this project. There are no particle effects, nothing fancy at all. Just rockets that shoot upward when you click a button. While Apple's example code can be quite comprehensive, its depth can make learning a challenge. The goal here is to make it easy to get your head around ECS and experiment.

Hope this helps on your adventures!

## A quick ECS crash course

**[Entities](https://developer.apple.com/documentation/realitykit/entity)** are objects that exist in 3D space. They can be positioned, they can have children, they can have parents. Sprawling hierchies of entities may be part of your RealityKit scene, analogous to view hierarchies in AppKit/UIKit. They *may* render to the screen, or they may act as invisible containers for other entities.

**[Components](https://developer.apple.com/documentation/realitykit/component)** are structs that attach to entities. Entities can have arbitrary numbers of components, but only one per _type_ of component.

Components let you attach state and configuration data to an entity. They're flexible, developer-defined context, but you have to use types that are serializable for editing in Reality Composer Pro, or you'll run into trouble. Think of components as elaborate tags. They make it easy for systems to find entities that are relevant to them.

**[Systems](https://developer.apple.com/documentation/realitykit/system)** are run on every frame. Use an `EntityQuery` to find entities that are relevant to a system. Systems use data stored in an entity's components to determine when and how to act on a given entity.

By reusing components across entities, you can allow systems to act upon arbitrary numbers of entities, gaining complex behavior from a simple set of ingredients.

## In this project

Three toy rockets each have a `LaunchComponent` with a different `thrustForce` value. Selecting the `Initiate Launch` button causes the rockets to lift upward.

After three seconds, the rockets are reset.

Drill into `Packages > RealityKitContent > Sources > RealityKitContent` to see the most interesting files:

<img width="256" alt="Screenshot 2024-04-01 at 1 44 12 PM" src="https://github.com/daniloc/MyFirstECS/assets/213358/6ab59fb0-4a2e-462a-9372-d0016c3dad5f">

(boy I hope they simplify that structure in visionOS 2.0)

## Issues?

Issues and PRs are welcome. This is technically my _third_ ECS exploration since Vision Pro delivered, I'm sure there are ways to improve.

## More visionOS projects

[PlanePlopper](https://github.com/daniloc/PlanePlopper): 3 method API for persistently attaching entities to WorldAnchors.

[GeometryLink](https://github.com/daniloc/GeometryLink): Stream a Blender mesh to Vision Pro and play with it.

**Want help with a visionOS project? [Hit me up](https://visionprototypes.com).**