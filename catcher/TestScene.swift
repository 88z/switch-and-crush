//
//  TestScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 01.10.2020.
//

import SpriteKit
import GameplayKit

class TestScene: SKScene {
    let b1 = SKShapeNode(circleOfRadius: 20)
    let b2 = SKShapeNode(circleOfRadius: 20)
    override func didMove(to view: SKView) {
        
        b1.fillColor = .red
        b1.position = CGPoint(x: size.width/2, y: size.height/2)
        b1.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        b1.physicsBody?.affectedByGravity = false
        b1.physicsBody?.pinned = false
        
        b2.fillColor = .blue
        b2.position = CGPoint(x: size.width/2-100, y: size.height/2)

        b2.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        b2.physicsBody?.affectedByGravity = false
        
        addChild(b1)
        addChild(b2)
        
        let pinJoint = SKPhysicsJointLimit.joint(withBodyA: b1.physicsBody!, bodyB: b2.physicsBody!, anchorA: b1.position, anchorB: b2.position)
        pinJoint.maxLength = 100
        physicsWorld.add(pinJoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let moveAction = SKAction.move(to: pos, duration: 0)
        b1.run(moveAction)

    }
    
}
