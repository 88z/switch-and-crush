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
        if isContactTest {
            return state
        }

        var state: State? = nil
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
    
    private var startAngle:CGFloat = 0
    private var endAngle: CGFloat = 0
    private var radius: CGFloat = 0
    private let width: CGFloat = ARC_OBSTACLE_THICKNESS
    
    convenience init(mask: Mask,
                     state: State,
                     center: CGPoint,
                     radius: CGFloat,
                     startAngle: CGFloat,
                     endAngle: CGFloat,
                     type: ObstacleType) {
        
        self.init(arcWithCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, width: 7)
        self.type = type
        self.state = state
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.radius = radius
        
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
    
    func shatteringDummy() -> SKNode {
        let dummy = SKNode()
        let atomsPer360Count = 48
        var startAngle:CGFloat = startAngle
        let atomAngle = 2*CGFloat.pi/CGFloat(atomsPer360Count)

        while startAngle < endAngle {
            let endAngle = startAngle + atomAngle
            let atom = StateNode(arcWithCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, width: width)
            atom.state = state
            atom.name = ATOM_NODE_NAME
            atom.physicsBody = SKPhysicsBody(polygonFrom: atom.path!)
            atom.physicsBody?.affectedByGravity = false
            atom.physicsBody?.categoryBitMask = 0b1000
            atom.physicsBody?.collisionBitMask = 0b1000
            atom.physicsBody?.restitution = 1
            dummy.addChild(atom)
            startAngle = endAngle
        }
        dummy.zRotation = firstRotatedParentRortation()
        return dummy
    }
    
    private func firstRotatedParentRortation() -> CGFloat {
        var parent = parent
        while parent != nil {
            if parent!.zRotation != 0 {
                return parent!.zRotation
            }
            parent = parent!.parent
        }
        return 0
    }
    
}
