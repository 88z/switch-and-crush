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
    private var speedMultiplier = CGFloat(10);
    convenience init(radius: CGFloat) {
        self.init(circleOfRadius:radius)
        name = String(describing: Hero.self)
        fillColor = colors[stateIndex];
        strokeColor = colors[stateIndex];
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
        let rate = 0.05;
        let relativeVelocity = CGVector(dx: newVector.dx-physicsBody.velocity.dx, dy: newVector.dy-physicsBody.velocity.dy);
        physicsBody.velocity=CGVector(dx: physicsBody.velocity.dx+relativeVelocity.dx*CGFloat(rate), dy: physicsBody.velocity.dy+relativeVelocity.dy*CGFloat(rate));
    }
    
    public func toggleState() {
        var newIndex = 0
        if let currentIndex = colors.firstIndex(of: fillColor) {
            if currentIndex < colors.count - 1 {
                newIndex = currentIndex + 1
            }
        }
        fillColor = colors[newIndex]
        strokeColor = colors[newIndex]
    }
}

