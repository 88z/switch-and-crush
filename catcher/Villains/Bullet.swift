//
//  Bullet.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.10.2020.
//

import SpriteKit

class Bullet: SKShapeNode {
    convenience init(collisionBitMask: UInt32, categoryBitMask: UInt32, contactBitMask: UInt32) {
        self.init(circleOfRadius:20)
        fillColor = .blue;
        strokeColor = .blue;
        name = String(describing: Bullet.self)
        physicsBody = SKPhysicsBody(circleOfRadius: 3)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.collisionBitMask = collisionBitMask
        physicsBody?.categoryBitMask = categoryBitMask
        physicsBody?.contactTestBitMask = contactBitMask
    }
}
