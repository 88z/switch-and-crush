//
//  File.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class RectObstacle: StateNode, Obstacle {
    func onAddedToScene() {
        
    }
    
    func willBeShattered() {}
    
    
    var node: SKNode {
        get {
            return self
        }
    }
    
    var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
            }
            get {
                physicsBody?.velocity.dy ?? 0
            }
    }
    
    var type: ObstacleType!
    
    convenience init(mask: Mask, width: CGFloat, type: ObstacleType) {
        let height: CGFloat
        switch type {
        case .circle:
            height = width
        case .thinPlank:
            height = 14
        case .squareStackPart:
            height = width/2
        default:
            height = PLANK_OBSTACLE_HEIGHT
        }
        

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        self.init(rect: rect)
        self.type = type
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(rectangleOf: rect.size, center: CGPoint(x: frame.midX, y: frame.midY))
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.density = 0.025
        physicsBody?.set(mask: mask)
        state = State.random()
    }
    
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
}
