//
//  Hero.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class Hero:StateNode {
    private var speedMultiplier = CGFloat(60);

    convenience init(radius: CGFloat) {
        self.init(circleOfRadius:radius)
        state = .first
        name = String(describing: Hero.self)
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
    }
    
    public func updateWith(moveVector:CGVector) {
        guard let physicsBody = physicsBody else {
            return
        }
        
        let newVector = CGVector(dx: moveVector.dx * speedMultiplier, dy: moveVector.dy*speedMultiplier)
        physicsBody.velocity = newVector
    }
}

