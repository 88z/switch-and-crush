//
//  GameScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //TODO
    //1. Remove second touch
    //2. попробовать использовать модель управления, где есть прямая зависимость между пальцем и героем
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private let hero = Hero(radius: 20)
    private var anchor = CGPoint.zero
    private var heroAnchor = CGPoint.zero
    
    private let gridGenerator = GridGenerator()

    override func didMove(to view: SKView) {
        let center = CGPoint(x: frame.midX, y: frame.midY)
        hero.position = center
        addChild(hero)
        hero.physicsBody?.collisionBitMask = 0b0001
        hero.physicsBody?.categoryBitMask = 0b0001
        view.isMultipleTouchEnabled = false;
        if let texture = gridGenerator.generate() {
            let bgNode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
            bgNode.position = center
            bgNode.zPosition = -1
            addChild(bgNode)
        }
        
        let cameraNode = SKCameraNode()
            
        cameraNode.position = center
            
        addChild(cameraNode)
        camera = cameraNode
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        anchor = pos
        heroAnchor = hero.position
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let newX =  heroAnchor.x + (pos.x - anchor.x)/1.5
        let newY =  heroAnchor.y + (pos.y - anchor.y)/1.5
        
        let moveAction = SKAction.move(to: CGPoint(x: newX, y:  newY), duration: 0)
        
        hero.run(moveAction)
        camera?.run(moveAction)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
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
    

}
