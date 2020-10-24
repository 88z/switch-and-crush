//
//  File.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class Obstacle: StateNode {
    convenience init(mask: Mask) {
        let rect = CGRect(x: 0, y: 0, width: 240, height: 21)
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
