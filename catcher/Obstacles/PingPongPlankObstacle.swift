//
//  PingPongObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 20.11.2022.
//

import Foundation
import SpriteKit

class PingPongPlankObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    let isStacked:Bool
    
    init(mask: Mask, colorScheme: ColorScheme, type: ObstacleType) {
        var isStacked = false
        var blinkInterval: TimeInterval = 0
        var swingSpeed: Speed = .none
        var acceleration = 0
        switch type {
        case .pingPongPlank(swingSpeed: let _swingSpeed, isStacked: let _isStacked, blinkInterval: let _blinkInterval, acceleration: let _acceleration):
            blinkInterval = _blinkInterval
            isStacked = _isStacked
            swingSpeed = _swingSpeed
            acceleration = _acceleration
        default:
            assertionFailure("incorrect type for " + String(describing: PendulumPlankObstacle.self))
        }
        self.isStacked = isStacked
        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval, acceleration: acceleration)
        self.type = type
        self.acceleration = acceleration
        let screenWidth = CGFloat(UIScreen.main.bounds.size.width)
        let ballPartWidth = screenWidth*0.2
        let sidePartWidth = screenWidth-ballPartWidth
        
        let ballPartState = State.random()
        let sidePartState = State.nextState(for: ballPartState)
        
        let leftPart = initPart(mask: mask, state: sidePartState, width: sidePartWidth)
        leftPart.node.position = CGPoint(x: -sidePartWidth, y: 0)
        
        let ballPart = initPart(mask: mask, state: ballPartState, width: ballPartWidth)
        ballPart.node.position = CGPoint(x: 1, y: 0)
        
        let rightPart = initPart(mask: mask, state: sidePartState, width: sidePartWidth)
        rightPart.node.position = CGPoint(x: ballPartWidth+1, y: 0)
        
        
        let height = ballPart.node.frame.size.height
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

        let moveRightAction = SKAction.moveBy(x: sidePartWidth, y:0, duration: duration)
        let moveLeftAction = SKAction.moveBy(x: -sidePartWidth, y:0, duration: duration)
        
        let action = SKAction.repeatForever(SKAction.sequence([moveRightAction, moveLeftAction]))
        
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: height), center: CGPoint(x: screenWidth/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        addChild(leftPart.node)
        addChild(rightPart.node)
        addChild(ballPart.node)
        leftPart.node.run(action)
        ballPart.node.run(action)
        rightPart.node.run(action)
        
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
