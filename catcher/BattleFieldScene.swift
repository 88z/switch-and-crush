//
//  GameScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import SpriteKit
import GameplayKit
import AudioToolbox


protocol BattleDelegate {
    func battleIsOver()
}

class BattleFieldScene: SKScene, SKPhysicsContactDelegate {

    private let hero = Hero(radius: 5)
    
    private var fallSpeed = CGFloat(-4)
   
    private var leftBorder:SKShapeNode!
    private var rightBorder:SKShapeNode!
    
    var battleDelegate: BattleDelegate?

    let heroMask = Mask(category: 0b0011, collision: 0b0010, contact: 0b0011)
    let borderMask = Mask(mask: 0b0010)
    let obstacleMask = Mask(category: 0b0001, collision: 0b0000, contact: 0b0001)
    
    var obstacleArranger: ObstacleArranger!
    
    func startBattle() {
        obstacleArranger = ObstacleArranger(scene: self, startPointY: hero.position.y - 400, leftBorderX: leftBorder.frame.maxX, rightBorderX: rightBorder.frame.minX, obstacleMask: obstacleMask)
        obstacleArranger.arrange()
    }
    
    override func didMove(to view: SKView) {
        let center = CGPoint(x: frame.midX, y: frame.midY)
        hero.position = center
        addChild(hero)
        
        hero.physicsBody?.set(mask: heroMask)

        let cameraNode = SKCameraNode()
        cameraNode.position = center
            
        addChild(cameraNode)
        camera = cameraNode
        
        physicsWorld.contactDelegate = self
        
        leftBorder = SKShapeNode(rect: CGRect(x: 0, y: frame.minY, width: 1, height: frame.height))
        let leftBorderBody = SKPhysicsBody(edgeLoopFrom: leftBorder.frame)
        leftBorderBody.affectedByGravity = false
        leftBorderBody.pinned = true
        leftBorderBody.restitution = 0
        leftBorderBody.friction = 0
        leftBorderBody.set(mask: borderMask)
        leftBorder.physicsBody = leftBorderBody
        leftBorder.fillColor = .clear
        leftBorder.strokeColor = .clear
        
        rightBorder = SKShapeNode(rect: CGRect(x: frame.maxX, y: frame.minY, width: 1, height: frame.height))
        let rightBorderBody = SKPhysicsBody(edgeLoopFrom: rightBorder.frame)
        rightBorderBody.affectedByGravity = false
        rightBorderBody.pinned = true
        rightBorderBody.restitution = 0
        rightBorderBody.friction = 0
        rightBorderBody.set(mask: borderMask)
        rightBorder.physicsBody = rightBorderBody
        rightBorder.fillColor = .clear
        rightBorder.strokeColor = .clear
        
        addChild(leftBorder)
        addChild(rightBorder)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        adjustCameraAndBorders()
        hero.updateWith(moveVector: CGVector(dx: frame.midX - hero.position.x, dy: fallSpeed))
    }
    
    func adjustCameraAndBorders() {
        let newPositionY = hero.position.y - frame.height/2 + 50
        camera?.position.y = newPositionY
        leftBorder.position.y = newPositionY
        rightBorder.position.y = newPositionY
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let aNode = contact.bodyA.node, let bNode = contact.bodyB.node else {
            return
        }
        
        let hero: Hero
        let obstacle: Obstacle
        if aNode is Hero {
            hero = aNode as! Hero
            obstacle = bNode as! Obstacle
        } else {
            hero = bNode as! Hero
            obstacle = aNode as! Obstacle
        }
        if hero.state == obstacle.state {
            breakObstacle(obstacle)
        } else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            battleDelegate?.battleIsOver()
        }
       
    }
    
    func breakObstacle(_ obstacle: Obstacle) {
        obstacleArranger.remove(obstacle: obstacle)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        speedUp()
    }
    
    func speedUp() {
        fallSpeed = fallSpeed - 0.05
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hero.toggleState()
    }
}
