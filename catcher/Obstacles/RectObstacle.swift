//
//  File.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class RectObstacle: StateNode, Obstacle {
    func shatteringDummy() -> SKNode {
        let dummy = SKNode()
        let atomSize = PLANK_ATOM_SIZE
        let rowCount = Int(frame.size.height/atomSize)
        let colCount = Int(frame.size.width / atomSize)
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atomOrigin = CGPoint(x: CGFloat(atomSize)*CGFloat(col), y: CGFloat(atomSize)*CGFloat(row))
                
                let atom = StateNode(rect:CGRect(origin: atomOrigin, size: CGSize(width: CGFloat(atomSize), height: CGFloat(atomSize))), state: state, colorScheme: colorScheme, blinkInterval: 0)
                atom.name = ATOM_NODE_NAME
                atom.lineWidth = 0
                atom.physicsBody = SKPhysicsBody(rectangleOf: atom.frame.size, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                atom.physicsBody?.affectedByGravity = false
                atom.physicsBody?.categoryBitMask = 0b1000
                atom.physicsBody?.collisionBitMask = 0b1000
                atom.physicsBody?.restitution = 1
                dummy.addChild(atom)
            }
        }
        
        return dummy
    }
    
    var isSolid: Bool = true
    
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
    
    convenience init(mask: Mask,
                     width: CGFloat,
                     state:State,
                     colorScheme: ColorScheme,
                     type: ObstacleType) {
        let height: CGFloat
        switch type {
        case .thinPlank:
            height = PLANK_OBSTACLE_HEIGHT/2
        default:
            height = 14
        }
        
        var blinkInterval: TimeInterval = 0
        switch type {
        case .plank(blinkInterval: let _blinkInterval), .thinPlank(blinkInterval: let _blinkInterval):
            blinkInterval = _blinkInterval
        default:
            assertionFailure("incorrect type for" + String(describing: RectObstacle.self))
        }


        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        self.init(rect: rect, state: state, colorScheme: colorScheme, blinkInterval: blinkInterval)
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
    }
    
    func state(at point: CGPoint) -> State? {
        return state
    }
    
    func contactTest(at point: CGPoint, state: State) -> Bool {
        return self.state(at: point) == state
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
