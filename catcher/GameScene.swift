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
    private var anchor = CGPoint.zero
    private var heroAnchor = CGPoint.zero

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
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        camera?.position = hero.position
    }
    
    func joystickMoved(_ newVector: CGVector) {
        hero.moveWith(vector: newVector)
    }


}
