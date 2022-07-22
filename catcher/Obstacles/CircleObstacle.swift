//
//  CircleObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 17.07.2022.
//

import Foundation
import SpriteKit

class CircleObstacle: StateNode, Obstacle {
    
    var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
            }
            get {
                physicsBody?.velocity.dy ?? 0
            }
    }
    
    var node: SKNode {
        get {
            return self
        }
    }
    
    var type: ObstacleType!
    var radius: CGFloat!
    
    func onAddedToScene() {}
    
    func state(at point: CGPoint) -> State {
        return state
    }
    
    func parts() -> [Obstacle] {
        return []
    }
    
    func parent() -> Obstacle? {
        var parent = parent
        while parent != nil && !(parent is Obstacle) {
            parent = parent?.parent
        }
        return parent as? Obstacle ?? nil
    }
    
    func willBeShattered() {}
    convenience init (mask: Mask, radius: CGFloat, type: ObstacleType) {
        self.init(circleOfRadius: radius)
        self.type = type
        self.radius = radius
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(circleOfRadius: radius, center: CGPoint(x: frame.midX, y: frame.midY))
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.density = 0.025
        physicsBody?.set(mask: mask)
        state = State.random()
    }
    
}
