//
//  GameScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class BattleFieldScene: SKScene, JoystickDelegate {
    

    private let hero = Hero(radius: 20)
    private var joystickVector = CGVector.zero

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
        hero.updateWith(moveVector: joystickVector)
    }
    
    func joystickMoved(_ newVector: CGVector) {
        joystickVector = newVector
    }

    func joystickDoubleTapped() {
        hero.toggleState()
    }

}
