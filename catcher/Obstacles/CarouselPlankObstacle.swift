//
//  CarouselPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 27.07.2022.
//

import Foundation
import SpriteKit

class CarouselPlankObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return true
        }
    }
    let isStacked: Bool
    
    let directionRight:Bool
    var shiftsCount = 0
    init(mask: Mask,
         colorScheme:ColorScheme,
         type: ObstacleType) {
        let width = UIScreen.main.bounds.size.width
       
        var isStacked = false
        var partsCount = 0
        var carouselSpeed: Speed = .none
        var blinkInterval: TimeInterval = 0
        var directionRight = false
        var acceleration = 0
        switch type {
        case .carouselPlank(partsCount: let _partsCount, carouselSpeed: let _carouselSpeed, directionRight: let _directionRight, isStacked: let _isStacked, blinkInterval: let _blinkInterval, acceleration: let _acceleration):
            isStacked = _isStacked
            partsCount = Int(round(Double(_partsCount) / 2.0)) * 2
            carouselSpeed = _carouselSpeed
            blinkInterval = _blinkInterval
            directionRight = _directionRight
            acceleration = _acceleration
        default:
            assertionFailure("incorrect type for " + String(describing: CarouselPlankObstacle.self))
        }
        self.isStacked = isStacked
        self.directionRight = directionRight
        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval, acceleration: acceleration)
        
        self.type = type
        name = String(describing: Obstacle.self)
        let partWidth = width/CGFloat(partsCount-1)
        var duration: CGFloat
        switch carouselSpeed {
        case .none:
            duration = CGFloat.infinity
        case .slow:
            duration = 6
        case .medium:
            duration = 4
        case .fast:
            duration = 2
        case .crazy:
            duration = 1
        }
        
        duration = duration/CGFloat(partsCount-1)
        
        var state = State.random()
        for i in 0..<partsCount {
            let part = initPart(mask: mask, state: state, width: partWidth-1)
            let x = directionRight ? (CGFloat(i)-1)*partWidth : CGFloat(i)*partWidth
            part.node.position = CGPoint(x:x, y: 0)
            state = .nextState(for: state)
            addChild(part.node)
            
            part.node.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.move(by: CGVector(dx: directionRight ? partWidth : -partWidth, dy: 0), duration: duration),
                SKAction.customAction(withDuration: 0, actionBlock: {[weak self] node, time in
                    guard let lastPart = self?.extremePart(right: directionRight),
                    node == lastPart.node else {
                        return
                    }
                    DispatchQueue.main.async {
                        if directionRight {
                            guard let leftPart = self?.extremePart(right: false) else {
                                return
                            }
                            node.position = CGPoint(x: leftPart.node.position.x - partWidth, y:0)
                        } else {
                            guard let rightPart = self?.extremePart(right: true) else {
                                return
                            }
                            node.position = CGPoint(x:rightPart.node.position.x+partWidth, y:0)
                        }
                        
                    }
                    
                    self?.shiftsCount+=1
                })
            ])))
        }
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: PLANK_OBSTACLE_HEIGHT), center: CGPoint(x: width/2, y: PLANK_OBSTACLE_HEIGHT/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0

    }
    
    func extremePart(right: Bool) -> Obstacle?{
        let parts = parts()
        guard parts.count > 0 else {
            return nil
        }
      
        var extremePart = parts.first!
        for part in parts {
            if right ? part.node.position.x > extremePart.node.position.x : part.node.position.x < extremePart.node.position.x {
                extremePart = part
            }
        }
        return extremePart
    }
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> Obstacle{
        if isStacked {
            return StackObstacle(mask: mask, width: width, states: [state, State.nextState(for: state)], colorScheme: colorScheme, type: .plankStack(blinkInterval: blinkInterval, acceleration: acceleration))
        } else {
            return RectObstacle(mask: mask, width: width, state: state, colorScheme: colorScheme, type: .plank(blinkInterval: blinkInterval, acceleration: acceleration))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
