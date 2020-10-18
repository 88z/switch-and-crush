//
//  GameScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class BattleFieldScene: SKScene, JoystickDelegate, SKPhysicsContactDelegate {
    
    

    private let hero = Hero(radius: 5)
    private var movingTargetX = CGFloat(0)
    private var heroAnchorX = CGFloat(0)
    private let fallSpeed = CGFloat(-100)

    override func didMove(to view: SKView) {
        let center = CGPoint(x: frame.midX, y: frame.midY)
        hero.position = center
        addChild(hero)
        
        hero.physicsBody?.collisionBitMask = 0b0001
        hero.physicsBody?.categoryBitMask = 0b0001

        let cameraNode = SKCameraNode()
        cameraNode.position = center
            
        addChild(cameraNode)
        camera = cameraNode
        
        physicsWorld.contactDelegate = self
        movingTargetX = frame.midX
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        adjustCamera()
        hero.updateWith(moveVector: CGVector(dx: movingTargetX - hero.position.x, dy: fallSpeed))
    }
    
    func adjustCamera() {
        let dy = frame.height/2 - 50
        camera?.position.y = hero.position.y - dy
    }
    
    func joystickTouched(at pos: CGPoint) {
        heroAnchorX = hero.position.x
    }
    
    func joystickMoved(to pos: CGPoint) {
        movingTargetX = pos.x + heroAnchorX

    }

    func joystickPressed() {
        hero.toggleState()
    }
    
    func joystickReleased() {
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
