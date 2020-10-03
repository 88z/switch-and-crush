//
//  Hero.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class Hero:SKShapeNode {
    private var colors = [UIColor.blue, UIColor.red]
    private var stateIndex = 0
    private var speedMultiplier = CGFloat(3);
    convenience init(radius: CGFloat) {
        self.init(circleOfRadius:radius)
        fillColor = colors[stateIndex];
        strokeColor = colors[stateIndex];
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
    }
    
}

