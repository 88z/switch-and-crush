//
//  JoystickScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 03.10.2020.
//

import SpriteKit

protocol JoystickDelegate {
    func joystickMoved(_ newVector: CGVector)
    func joystickPressed()
    func joystickReleased()
}

class JoystickScene: SKScene {
    private var color = UIColor.white
    private let coreRadius = CGFloat(25)
    private let stickRadius = CGFloat(25)
    private let borderRadius = CGFloat(50)
    private var core:SKShapeNode!
    private var stick:SKShapeNode!
    
    private var touchStartSeconds:TimeInterval = 0
    
    var joystickDelegate: JoystickDelegate?
    
    var calmDownTimer: Timer?
    var savedStickCoreDelta = CGPoint.zero
    
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
        alpha = 0.0
    }
    
    func touchDown(atPoint pos : CGPoint, tapCount: Int) {
        calmDownTimer?.invalidate()
        stick.position = pos
        core.position = CGPoint(x: pos.x - savedStickCoreDelta.x, y: pos.y - savedStickCoreDelta.y)
        touchStartSeconds = NSDate().timeIntervalSince1970
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let moveAction = SKAction.move(to: pos, duration: 0)
        stick.run(moveAction)
        let vector = convert(stick.position, to: core)
        var len = hypot(vector.x, vector.y)
        len = len == 0 ? 1 : len
        joystickDelegate?.joystickMoved(CGVector(dx: borderRadius*vector.x/len, dy: borderRadius*vector.y/len))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if NSDate().timeIntervalSince1970 - touchStartSeconds <= 0.3 {
            joystickDelegate?.joystickPressed()
        }
        
        savedStickCoreDelta = CGPoint(x: stick.position.x - core.position.x, y: stick.position.y-core.position.y)
        
        //ждем время и только после этого отпускаем stick
        calmDownTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [unowned self] timer in
            let moveAction = SKAction.move(to: self.core.position, duration: 0.1)
            stick.run(moveAction)
            savedStickCoreDelta = .zero
            joystickDelegate?.joystickReleased()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self), tapCount:t.tapCount)
            
        }
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
