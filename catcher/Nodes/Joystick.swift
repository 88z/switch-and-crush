//
//  Joystick.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

enum JoystickError: Error {
    case runtimeError(String)
}

protocol JoystickDelegate {
    func joystickMoved(_ newVector: CGVector)
}

class Joystick:SKNode {
    private var color = UIColor.white
    private let coreRadius = CGFloat(25)
    private let stickRadius = CGFloat(25)
    private let borderRadius = CGFloat(50)
    private var core:SKShapeNode!
    private var stick:SKShapeNode!
    
   
    var delegate: JoystickDelegate?
    
    convenience init(color: UIColor) {
        self.init()
        self.color = color
        
        core = SKShapeNode(circleOfRadius: borderRadius)
        stick = SKShapeNode(circleOfRadius: stickRadius)
        
        let coreBody = SKPhysicsBody(circleOfRadius: coreRadius)
        coreBody.affectedByGravity = false
        core.physicsBody = coreBody
        core.strokeColor = color
        core.lineWidth = 1.0
        addChild(core)
        
        let stickBody = SKPhysicsBody(circleOfRadius: stickRadius)
        stickBody.affectedByGravity = false
        stickBody.allowsRotation = true
        stick.physicsBody = stickBody
        stick.strokeColor = color
        stick.lineWidth = 1.0
        addChild(stick)
        
        alpha = 0.1
        
    }
    
    private func setupPhysicsIfNeed() {
        guard let scene = scene, core.physicsBody!.joints.count == 0 else {
            return
        }
        
        let coreStickJoint = SKPhysicsJointLimit.joint(withBodyA: stick.physicsBody!, bodyB: core.physicsBody!, anchorA: position, anchorB: position)
        coreStickJoint.maxLength = borderRadius
        scene.physicsWorld.add(coreStickJoint)
    }
    
    
    
    public func move(position:CGPoint) {
        setupPhysicsIfNeed()
        if let scene = scene {
            let newCorePosition = scene.convert(position, to: self)
            let moveAction = SKAction.move(to: newCorePosition, duration: 0)
            stick.run(moveAction)
            
            let vector = scene.convert(position, to: core)
            delegate?.joystickMoved(CGVector(dx: vector.x, dy: vector.y))
        }
    }
    
    public func calm(){
        stick.removeAllActions()
        let moveAction = SKAction.move(to: core.position, duration: 0.3)
        stick.run(moveAction)
        let delegateAction = SKAction.customAction(withDuration: 0.3) { (node, elapsedTime) in
            let vector = self.convert(node.position, to: self.core)
            self.delegate?.joystickMoved(CGVector(dx: vector.x, dy: vector.y))
        }
        stick.run(delegateAction);
    }
    
    
    public func set(collisionBitMask: UInt32, categoryBitMask: UInt32) {
        core.physicsBody?.collisionBitMask = collisionBitMask
        core.physicsBody?.categoryBitMask = categoryBitMask
        stick.physicsBody?.collisionBitMask = collisionBitMask
        stick.physicsBody?.categoryBitMask = categoryBitMask
    }
}
