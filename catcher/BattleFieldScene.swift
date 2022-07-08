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
    func didFinish(level:Level)
}

protocol BattleFieldSceneDelegate: SKSceneDelegate {
    func crashAnimationFinished(scene: BattleFieldScene)
}


class BattleFieldScene: SKScene, SKPhysicsContactDelegate {
    private let hero = Hero(radius: 10)

    private let heroTopOffset: CGFloat

    var heroState: State {
        return hero.state
    }
    
    private var fallSpeed: CGFloat {
        get {
            guard let obstacle = obstacles().first as? Obstacle else {
                return CGFloat(0)
            }
            return obstacle.velocity
        }
        set {
            let obstacles = obstacles()
            for obstacle in obstacles {
                if let obstacle = obstacle as? Obstacle {
                    obstacle.velocity = newValue
                }
            }
        }
    }
    
    var battleDelegate: BattleDelegate?
    let heroMask = Mask(category: 0b0011, collision: 0b0010, contact: 0b0011)
    let obstacleMask = Mask(category: 0b0001, collision: 0b0000, contact: 0b0001)
    var obstacleArranger: ObstacleArranger!
    private var level: Level?
    private var progress: Int = 0
    
    init (size: CGSize, heroTopOffset: CGFloat) {
        self.heroTopOffset = heroTopOffset
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.background()
        hero.position = CGPoint(x: frame.midX, y: frame.maxY-heroTopOffset)
        addChild(hero)
        
        hero.physicsBody?.set(mask: heroMask)

        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
            
        addChild(cameraNode)
        camera = cameraNode
        
        physicsWorld.contactDelegate = self
    }
    
    func start(level: Level) {
        self.level = level
        self.fallSpeed = level.initialSpeed
        self.isUserInteractionEnabled = level.userInterationEnabled
        hero.state = level.initialState
        obstacleArranger = ObstacleArranger(scene: self, obstacleCount: level.obstacleCount, firstObstacleState: hero.state, startPointY: frame.minY-50, leftBorderX: frame.minX, rightBorderX: frame.maxX, obstacleMask: obstacleMask, initialSpeed: level.initialSpeed)
        obstacleArranger.arrange()
    }
    
    private func adjustCameraAndBorders() {
        let newPositionY = hero.position.y - frame.height/2 + heroTopOffset
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
            breakHero(hero, contactPoint: contact.contactPoint)
            battleDelegate?.crashed()
        }
       
    }
    
    func breakHero(_ hero: Hero, contactPoint: CGPoint) {
        let shatter = HeroShatter(hero: hero)
        shatter.shatter(contactPoint: contactPoint) {}
        dimObstacles()
        guard let delegate = delegate as? BattleFieldSceneDelegate else {
            return
        }
        delegate.crashAnimationFinished(scene: self)
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
        if progress >= obstacleCount {
            if let level = self.level {
                battleDelegate?.didFinish(level: level)
            }
        }
    }
    
    func obstacles() -> [SKNode] {
        return self[String(describing: Obstacle.self)]
    }
    
    func speedUp() {
        guard let level = self.level else {
            return
        }
        fallSpeed = fallSpeed + level.acceleration
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hero.toggleState()
    }
    
    func dimObstacles() {
        let dimAction = SKAction.fadeAlpha(to: 0.5, duration: 0.5)
        for obstacle in obstacles()  {
            obstacle.run(dimAction)
        }
    }
    
}
