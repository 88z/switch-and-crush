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
    private var obstacleArranger: ObstacleArranger?
    let heroMask = Mask(category: 0b0011, collision: 0b0010, contact: 0b0011)
    let obstacleMask = Mask(category: 0b0001, collision: 0b0000, contact: 0b0010)
    
    private var level: Level?
    private var progress: Int = 0
    
    private let counterNode = SKLabelNode()
    
    init (size: CGSize, heroTopOffset: CGFloat) {
        self.heroTopOffset = heroTopOffset
        super.init(size: size)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        isUserInteractionEnabled = false
        
        backgroundColor = UIColor.background()
        hero.position = CGPoint(x: frame.midX, y: frame.maxY-heroTopOffset)
        addChild(hero)
        hero.physicsBody?.set(mask: heroMask)

        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(cameraNode)
        camera = cameraNode
        
        counterNode.position = CGPoint(x: frame.midX, y: frame.maxY - 75)
        addChild(counterNode)
        
        physicsWorld.contactDelegate = self
    }
    
    func start(level: Level, shouldShowCounter:Bool = true) {
        self.level = level
        self.fallSpeed = level.initialSpeed
        self.isUserInteractionEnabled = level.userInterationEnabled
        hero.state = level.initialState
        progress = 0
        let obstacleArranger = ObstacleArranger(scene: self, obstacleTypes: level.obstacleTypes, firstObstacleState: hero.state, startPointY: frame.minY-50, leftBorderX: frame.minX, rightBorderX: frame.maxX, obstacleMask: obstacleMask, initialSpeed: level.initialSpeed)
        obstacleArranger.arrangeFirst()
//        obstacleArranger.arrangeAll()
        
        self.obstacleArranger = obstacleArranger
        
        counterNode.isHidden = !shouldShowCounter
        if shouldShowCounter {
            updateCounter()
        }
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
        } else if bNode is Hero {
            hero = bNode as! Hero
            obstacle = aNode as! Obstacle
        } else {
            fatalError("unknown collisions")
        }
        
        guard let obstacleBodies = hero.physicsBody?.allContactedBodies() else {
            return
        }
        
        var states:[State] = []
        for obstacleBody in obstacleBodies {
            let obstacle = obstacleBody.node as! Obstacle
            let contactPoint = convert(CGPoint(x: contact.contactPoint.x,
                                               y: contact.contactPoint.y-2),
                                       to: obstacle.node)
            guard let state = obstacle.state(at: contactPoint,
                                             isContactTest: true) else {
                continue
            }
            states.append(state)
        }
        
        if states.contains(hero.state) {
            breakObstacle(obstacle, contactPoint: contact.contactPoint)
            obstacleArranger?.arrangeNext()
        } else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            obstacleArranger?.arrangeAll()
            breakHero(hero, contactPoint: contact.contactPoint)
            battleDelegate?.crashed()
        }
       
    }
    
    func breakHero(_ hero: Hero, contactPoint: CGPoint) {
        let shatter = HeroShatterer(hero: hero)
        shatter.shatter(contactPoint: contactPoint) {}
        dimObstacles()
        guard let delegate = delegate as? BattleFieldSceneDelegate else {
            return
        }
        delegate.crashAnimationFinished(scene: self)
    }
    
    func shatterer(for obstacle: Obstacle) ->Shatterer {
        switch obstacle.type {
        case .arc, .animatedRing(segmentsCount: _, rotationSpeed: _, isStacked: _), .fragmentedRing(segmentsCount: _, rotationSpeed: _, isStacked: _):
            return RingObstacleShatterer(obstacle: obstacle)
        default:
            return PlankObstacleShatterer(obstacle: obstacle)
        }
    }
    
    func breakObstacle(_ obstacle: Obstacle, contactPoint: CGPoint) {
        guard let obstacleCount = level?.obstacleTypes.count,
              obstacle.node.scene != nil
        else {
            return
        }
        shatterer(for: obstacle).shatter(contactPoint: contactPoint)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        speedUp()
        progress += 1
        updateCounter()
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
    
    func updateCounter() {
        let text = "\(progress) / \(ObstacleType.points(in: level?.obstacleTypes ?? []))"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([.foregroundColor: UIColor .text(), .font: FONT(size: 24)], range: NSRange(location: 0, length: text.count))
        counterNode.attributedText = attributedText
    }
}
