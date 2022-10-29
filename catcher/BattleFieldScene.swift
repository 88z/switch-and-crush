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
    private var hero: Hero?

    private let heroTopOffset: CGFloat

    var heroState: State? {
        return hero?.state
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
    
    private var obstacleAlpha: CGFloat = 1
    
    var isDimmed: Bool {
        get {
            return obstacleAlpha < 1
        }
        set {
            obstacleAlpha = newValue ? 0.5 : 1
            let dimAction = SKAction.fadeAlpha(to: obstacleAlpha, duration: 0.5)
            for obstacle in obstacles()  {
                obstacle.run(dimAction)
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
    
    private weak var lastObstacle: Obstacle?
    
    var crushedObstaclesCount: Int {
        get {
            return progress
        }
    }
    
    init (size: CGSize, heroTopOffset: CGFloat) {
        self.heroTopOffset = heroTopOffset
        super.init(size: size)

    }
    
    private func placeHero(state:State, colorScheme: ColorScheme) {
        hero?.removeFromParent()
        let hero = Hero(radius: 10, state: state, colorScheme: colorScheme)
        hero.position = CGPoint(x: frame.midX, y: frame.maxY-heroTopOffset)
        addChild(hero)
        hero.physicsBody?.set(mask: heroMask)
        self.hero = hero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        isUserInteractionEnabled = false
        
        backgroundColor = UIColor.background()
        

        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(cameraNode)
        camera = cameraNode
        
        counterNode.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(counterNode)
        
        physicsWorld.contactDelegate = self
    }
    
    func start(level: Level, shouldShowCounter:Bool = true, shouldPlaceHero: Bool) {
        self.level = level
        self.fallSpeed = level.initialSpeed
        self.isUserInteractionEnabled = level.userInterationEnabled
        if shouldPlaceHero {
            placeHero(state: level.initialState, colorScheme: level.colorScheme)
        }
        
        progress = 0
        let obstacleArranger = ObstacleArranger(scene: self,
                                                initialObstacleTypes: level.initialObstacleTypes,
                                                obstacleTypesForTail: level.obstacleTypesForTail,
                                                levelCapacity: level.capacity,
                                                firstObstacleState: hero?.state ?? .first,
                                                startPointY: frame.minY-50,
                                                leftBorderX: frame.minX,
                                                rightBorderX: frame.maxX,
                                                obstacleMask: obstacleMask,
                                                colorScheme: level.colorScheme)
        let obstacles = obstacleArranger.arrangeFirst(speed: level.initialSpeed)
        lastObstacle = obstacles.last
        
        self.obstacleArranger = obstacleArranger
        
        counterNode.isHidden = !shouldShowCounter
        if shouldShowCounter {
            updateCounter()
        }
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
        
        var needBreakObstacle = false
        for obstacleBody in obstacleBodies {
            let obstacle = obstacleBody.node as! Obstacle
            let contactPoint = convert(CGPoint(x: contact.contactPoint.x,
                                               y: contact.contactPoint.y-2),
                                       to: obstacle.node)
            
            if obstacle.contactTest(at: contactPoint, state: hero.state) {
                needBreakObstacle = true
                break
            }
        }
        
        if needBreakObstacle {
            breakObstacle(obstacle, contactPoint: contact.contactPoint)
        } else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            breakHero(hero, contactPoint: contact.contactPoint)
            battleDelegate?.crashed()
        }
       
    }
    
    func breakHero(_ hero: Hero, contactPoint: CGPoint) {
        let shatter = HeroShatterer(hero: hero)
        shatter.shatter(contactPoint: contactPoint) {}
        guard let delegate = delegate as? BattleFieldSceneDelegate else {
            return
        }
        delegate.crashAnimationFinished(scene: self)
    }
    
    func shatterer(for obstacle: Obstacle) ->Shatterer {
        switch obstacle.type {
        case .arc, .animatedRing(segmentsCount: _,
                                 rotationSpeed: _,
                                 isStacked: _),
                .fragmentedRing(segmentsCount: _,
                                rotationSpeed: _,
                                isStacked: _,
                                blinkInterval: _):
            return RingObstacleShatterer(obstacle: obstacle)
        default:
            return PlankObstacleShatterer(obstacle: obstacle)
        }
    }
    
    func breakObstacle(_ obstacle: Obstacle, contactPoint: CGPoint) {
        guard let capacity = level?.capacity,
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
        if progress == capacity {
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
        hero?.toggleState()
    }
    
    func updateCounter() {
        let text = level?.capacity ?? 0 > 0 ? "\(progress) / \(level?.capacity ?? 0)" : "\(progress)"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([.foregroundColor: UIColor .text(), .font: FONT(size: 40)], range: NSRange(location: 0, length: text.count))
        counterNode.attributedText = attributedText
    }
    
    override func didFinishUpdate() {
        guard let lastObstacle = lastObstacle else {
            return
        }

        if lastObstacle.node.calculateAccumulatedFrame().maxY > frame.minY {
            self.lastObstacle = obstacleArranger?.arrangeNext(speed: fallSpeed)
            self.lastObstacle?.node.alpha = obstacleAlpha
            
            //удаляем улетевшие препятствия в момент добавления новых,
            //делаю так, чтобы не дергать это слишком часто
            //можно это запускать и по таймеру, но пусть будет тут
            removeFlownAwayObstacles()
        }
    }
    
    private func removeFlownAwayObstacles() {
        let obstacles = obstacles()
        for obstacle in obstacles {
            if obstacle.calculateAccumulatedFrame().minY  > frame.maxY {
                obstacle.removeFromParent()
            }
            
        }
    }
}
