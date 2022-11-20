//
//  MultistateAnimatedPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class PendulumPlankObstacle: MultiStateObstacle {
    
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    let isStacked:Bool
    let partsCount: Int
    
    init(mask: Mask, colorScheme: ColorScheme, type: ObstacleType) {
        var isStacked = false
        var blinkInterval: TimeInterval = 0
        var swingSpeed: Speed = .none
        var acceleration = 0
        var partsCount = 0
        switch type {
        case .pendulumPlank(partsCount: let _partsCount, swingSpeed: let _swingSpeed, isStacked: let _isStacked, blinkInterval: let _blinkInterval, acceleration: let _acceletation):
            blinkInterval = _blinkInterval
            isStacked = _isStacked
            swingSpeed = _swingSpeed
            acceleration = _acceletation
            partsCount = _partsCount
        default:
            assertionFailure("incorrect type for " + String(describing: PendulumPlankObstacle.self))
        }
        self.isStacked = isStacked
        self.partsCount = partsCount

        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval, acceleration: acceleration)
        self.type = type
        self.acceleration = acceleration
        let width = CGFloat(UIScreen.main.bounds.size.width/CGFloat(partsCount-1))
        
        var parts:[Obstacle] = []
        var state = State.random()
        for i in 0..<partsCount {
            let part = initPart(mask: mask, state: state, width: width)
            let x = width*CGFloat(i-1)+CGFloat(i)
            part.node.position = CGPoint(x:x, y:0)
            parts.append(part)
            state = State.nextState(for: state)
        }
        
        let height = parts.first?.node.frame.size.height ?? 0
        var duration:TimeInterval
        
        switch swingSpeed {
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

        let moveRightAction = SKAction.moveBy(x: width, y:0, duration: duration)
        let moveLeftAction = SKAction.moveBy(x: -width, y:0, duration: duration)
        
        let action = SKAction.repeatForever(SKAction.sequence([moveRightAction, moveLeftAction]))
        
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        for part in parts {
            addChild(part.node)
            part.node.run(action)
            
        }
        
    }
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> Obstacle{
        if isStacked {
            return StackObstacle(mask: mask,
                                 width: width,
                                 states: [state, State.nextState(for: state)],
                                 colorScheme: colorScheme,
                                 type: .plankStack(blinkInterval: blinkInterval, acceleration: acceleration))
        } else {
            return RectObstacle(mask: mask,
                                width: width,
                                state: state,
                                colorScheme: colorScheme,
                                type: .plank(blinkInterval: blinkInterval, acceleration: acceleration))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
