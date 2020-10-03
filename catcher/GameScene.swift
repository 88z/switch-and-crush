//
//  GameScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, JoystickDelegate {
    
    //TODO
    //1. Remove second touch
    //2. попробовать использовать модель управления, где есть прямая зависимость между пальцем и героем
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private let hero = Hero(radius: 20)
    private let joystick = Joystick(color: .white)

    
    override func didMove(to view: SKView) {
        hero.position = CGPoint(x: size.width/2, y: size.height/2)
        joystick.position = CGPoint(x: size.width/2, y: 100)
        joystick.delegate = self
        addChild(hero)
        addChild(joystick)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        
        physicsBody = border
        
        border.categoryBitMask = 0b0001
        border.collisionBitMask = 0b0001
        hero.physicsBody?.collisionBitMask = 0b0001
        hero.physicsBody?.categoryBitMask = 0b0001
        
        joystick.set(collisionBitMask: 0b0010, categoryBitMask: 0b0010)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        joystick.move(position: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        joystick.calm()
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func joystickMoved(_ newVector: CGVector) {
        hero.moveWith(vector: newVector)
    }
}
