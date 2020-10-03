//
//  JoystickScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 03.10.2020.
//

import SpriteKit

protocol JoystickDelegate {
    func joystickMoved(_ newVector: CGVector)
}

class JoystickScene: SKScene {
    private var color = UIColor.white
    private let coreRadius = CGFloat(25)
    private let stickRadius = CGFloat(25)
    private let borderRadius = CGFloat(50)
    private var core:SKShapeNode!
    private var stick:SKShapeNode!
    
    var joystickDelegate: JoystickDelegate?
    
    override func didMove(to view: SKView) {
        let startPosition = CGPoint(x: frame.midX, y: 100)
        
        
        core = SKShapeNode(circleOfRadius: borderRadius)
        core.position = startPosition
        let coreBody = SKPhysicsBody(circleOfRadius: coreRadius)
        coreBody.affectedByGravity = false
        core.physicsBody = coreBody
        core.strokeColor = color
        core.lineWidth = 1.0
        addChild(core)
        
        stick = SKShapeNode(circleOfRadius: stickRadius)
        stick.position = startPosition
        let stickBody = SKPhysicsBody(circleOfRadius: stickRadius)
        stickBody.affectedByGravity = false
        stickBody.allowsRotation = true
        stick.physicsBody = stickBody
        stick.strokeColor = color
        stick.lineWidth = 1.0
        addChild(stick)
        
        let coreStickJoint = SKPhysicsJointLimit.joint(withBodyA: stick.physicsBody!, bodyB: core.physicsBody!, anchorA: startPosition, anchorB: startPosition)
        coreStickJoint.maxLength = borderRadius
        physicsWorld.add(coreStickJoint)
        
        alpha = 0.1
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let moveAction = SKAction.move(to: pos, duration: 0)
        stick.run(moveAction)
        let vector = convert(stick.position, to: core)
        joystickDelegate?.joystickMoved(CGVector(dx: vector.x, dy: vector.y))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        stick.removeAllActions()
        let moveAction = SKAction.move(to: core.position, duration: 0.3)
        stick.run(moveAction)
        let delegateAction = SKAction.customAction(withDuration: 0.3) { (node, elapsedTime) in
            let vector = self.convert(node.position, to: self.core)
            self.joystickDelegate?.joystickMoved(CGVector(dx: vector.x, dy: vector.y))
        }
        stick.run(delegateAction);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
