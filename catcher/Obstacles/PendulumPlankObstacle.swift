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
    
    init(mask: Mask, swingSpeed: Speed, isStacked: Bool, colorScheme: ColorScheme, blinkInterval: TimeInterval) {
        self.isStacked = isStacked
        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval)
        let width = UIScreen.main.bounds.size.width
        let leftPartState = State.random()
        let rightPartState = State.nextState(for: leftPartState)
        
        let leftObstacle = initPart(mask: mask, state: leftPartState, width: width)
        leftObstacle.node.position = CGPoint(x: -width, y: 0)
        let rightObstacle = initPart(mask: mask, state: rightPartState, width: width)
        rightObstacle.node.position = CGPoint(x: 1, y: 0)
        
        let height = rightObstacle.node.frame.size.height
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
        
        
        addChild(leftObstacle.node)
        addChild(rightObstacle.node)
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        leftObstacle.node.run(action)
        rightObstacle.node.run(action)
        
    }
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> Obstacle{
        if isStacked {
            return StackObstacle(mask: mask,
                                 width: width,
                                 states: [state, State.nextState(for: state)],
                                 colorScheme: colorScheme,
                                 blinkInterval: blinkInterval,
                                 type: .plankStack(blinkInterval: blinkInterval))
        } else {
            return RectObstacle(mask: mask,
                                width: width,
                                state: state,
                                colorScheme: colorScheme,
                                blinkInterval: blinkInterval,
                                type: .plank(blinkInterval: blinkInterval))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
