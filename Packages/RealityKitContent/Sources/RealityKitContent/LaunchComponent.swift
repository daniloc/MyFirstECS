import RealityKit

// Ensure you register this component in your app’s delegate using:
// LaunchComponent.registerComponent()
public struct LaunchComponent: Component, Codable {
    var thrustForce: Float = 1
    var timeLaunched: Double = 0
    public var launchInitiated: Bool = false
    
    public init() {
    }
}
