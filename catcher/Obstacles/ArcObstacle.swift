//
//  ArcObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 28.07.2022.
//

import Foundation
import SpriteKit

class ArcObstacle: StateNode, Obstacle {
    var isSolid: Bool = true
    
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
    
    func onAddedToScene() {
        
    }
    
    func state(at point: CGPoint) -> State? {
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
    
    convenience init(mask: Mask, state: State, center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, type: ObstacleType) {
        
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let innerPath = UIBezierPath()
        let innerRadius = radius-7
        innerPath.addArc(withCenter: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let innerCircleEnd = innerPath.currentPoint
        
        path.addLine(to: innerCircleEnd)
        path.addArc(withCenter: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        path.close()
        self.init(path: path.cgPath)
        self.type = type
        self.state = state
        self.name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.density = 0.025
        physicsBody?.set(mask: mask)
        
    }
    
}
