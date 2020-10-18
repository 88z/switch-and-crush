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
    private var joystickVector: CGVector?
    private var shooter: Shooter!

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
        
        shooter = Shooter(scene: self, target: hero, bulletCollisionBitMask: 0b0000, bulletCategoryBitMask: 0b0010, bulletContactBitMask: 0b0001)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            self.shooter.shoot(scatter: 100)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        camera?.position = hero.position
        shooter.rungarbageLoop()
        guard let joystickVector = joystickVector else {
            return
        }
        camera?.position = hero.position
        hero.updateWith(moveVector: joystickVector)
        
        
    }
    
    func joystickMoved(_ newVector: CGVector) {
        joystickVector = newVector
    }

    func joystickPressed() {
        hero.toggleState()
    }
    
    func joystickReleased() {
        joystickVector = .zero
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let aName = contact.bodyA.node?.name, let bName = contact.bodyB.node?.name else {
            return
        }
        let names = [String(describing: Bullet.self), String(describing: Hero.self)]
        
        if names.contains(aName) && names.contains(bName) && aName != bName {
            print("killed")
        }
    }
}
