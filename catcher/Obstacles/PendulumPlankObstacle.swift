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
    
    init(mask: Mask, swingSpeed: Speed) {
        let width = UIScreen.main.bounds.size.width
        let leftPartState = State.random()
        let rightPartState = State.nextState(for: leftPartState)
        
        let leftObstacle = RectObstacle(mask: mask, width: width, type: .plank)
        leftObstacle.position = CGPoint(x: -width, y: 0)
        leftObstacle.state = leftPartState
        let rightObstacle = RectObstacle(mask: mask, width: width, type: .plank)
        rightObstacle.position = CGPoint(x: 1, y: 0)
        rightObstacle.state = rightPartState
        
        let height = rightObstacle.frame.size.height
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
        
        super.init()
        addChild(leftObstacle)
        addChild(rightObstacle)
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        leftObstacle.run(action)
        rightObstacle.run(action)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
