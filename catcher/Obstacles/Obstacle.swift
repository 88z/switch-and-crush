//
//  File.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class Obstacle: StateNode {
    var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
            }
            get {
                physicsBody?.velocity.dy ?? 0
            }
    }
    convenience init(mask: Mask, width: CGFloat) {
        let rect = CGRect(x: 0, y: 0, width: width, height: 21)
        self.init(rect: rect)
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(rectangleOf: rect.size, center: CGPoint(x: frame.midX, y: frame.midY))
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.set(mask: mask)
    }
    
    
}
