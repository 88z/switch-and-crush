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
    
    func state(at point: CGPoint, isContactTest: Bool) -> State? {
//        return state
        if isContactTest {
            return state
        }
        guard let scene = scene else {
            fatalError("obstacle is not on scene")
        }
        var state: State? = nil
        let pnt = scene.convert(point, to: self.parent()?.node ?? scene)
        guard let path = path else {
            return state
        }
        if path.contains(point) {
            state = self.state
        }
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
        
        self.init(arcWithCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, width: 7)
        self.type = type
        self.state = state
        self.name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(polygonFrom: path!)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.density = 0.025
        physicsBody?.set(mask: mask)
        
    }
    
}
