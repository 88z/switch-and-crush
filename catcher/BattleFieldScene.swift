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
    func crashed()
    func levelFinished()
}

class BattleFieldScene: SKScene, SKPhysicsContactDelegate {

    private let hero = Hero(radius: 8)
    private var fallSpeed = CGFloat(-3)
    var battleDelegate: BattleDelegate?
    let heroMask = Mask(category: 0b0011, collision: 0b0010, contact: 0b0011)
    let obstacleMask = Mask(category: 0b0001, collision: 0b0000, contact: 0b0001)
    var obstacleArranger: ObstacleArranger!
    private var level: Level?
    private var progress: Int = 0
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 4/255, green: 15/255, blue: 22/255, alpha: 1)
        let center = CGPoint(x: frame.midX, y: frame.midY)
        hero.position = center
        addChild(hero)
        
        hero.physicsBody?.set(mask: heroMask)

        let cameraNode = SKCameraNode()
        cameraNode.position = center
            
        addChild(cameraNode)
        camera = cameraNode
        
        physicsWorld.contactDelegate = self
    }
    
    func start(level: Level) {
        self.level = level
        self.fallSpeed = -level.initialSpeed
        obstacleArranger = ObstacleArranger(scene: self, obstacleCount: level.obstacleCount, firstObstacleState: hero.state, startPointY: hero.position.y - frame.size.height, leftBorderX: frame.minX, rightBorderX: frame.maxX, obstacleMask: obstacleMask)
        obstacleArranger.arrange()
    }
    
    override func update(_ currentTime: TimeInterval) {
        adjustCameraAndBorders()
        hero.updateWith(moveVector: CGVector(dx: frame.midX - hero.position.x, dy: fallSpeed))
    }
    
    func adjustCameraAndBorders() {
        let newPositionY = hero.position.y - frame.height/2 + 50
        camera?.position.y = newPositionY
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
            breakObstacle(obstacle, contactPoint: contact.contactPoint)
        } else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            battleDelegate?.crashed()
        }
       
    }
    
    func breakObstacle(_ obstacle: Obstacle, contactPoint: CGPoint) {
        let shatter = ObstacleShatter(obstacle: obstacle)
        shatter.shatter(contactPoint: contactPoint)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        speedUp()
        progress += 1
        guard let obstacleCount = level?.obstacleCount else {
            return
        }
        if progress == obstacleCount - 1 {
            battleDelegate?.levelFinished()
        }
    }
    
    func speedUp() {
        guard let level = self.level else {
            return
        }
        fallSpeed = fallSpeed - level.acceleration
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hero.toggleState()
    }
}
