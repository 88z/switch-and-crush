//
//  GatePlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 20.11.2022.
//

import Foundation
import SpriteKit

class GatePlankObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    let isStacked:Bool
    init(mask: Mask, colorScheme: ColorScheme, type: ObstacleType) {
        self.isStacked = false
        super.init(colorScheme: colorScheme, blinkInterval: 0, acceleration: 0)
        let width = CGFloat(UIScreen.main.bounds.size.width)
        
        let state = State.first
        
        
        let part1Left = initPart(mask: mask, state: state, width: width/2)
        part1Left.node.position = CGPoint(x: -width/2, y: 0)
        part1Left.node.zPosition = 2
        let part1Right = initPart(mask: mask, state: state, width: width/2)
        part1Right.node.position = CGPoint(x: width, y: 0)
        part1Right.node.zPosition = 2
        addChild(part1Left.node)
        addChild(part1Right.node)
        
        let part2Left = initPart(mask: mask, state: State.nextState(for: state), width: width/2)
        part2Left.node.position = CGPoint(x: 0, y: 0)
        part2Left.node.zPosition = 1
        let part2Right = initPart(mask: mask, state: State.nextState(for: state), width: width/2)
        part2Right.node.position = CGPoint(x: width/2, y: 0)
        part2Right.node.zPosition = 1
        addChild(part2Left.node)
        addChild(part2Right.node)
        
        let height = part1Left.node.frame.size.height
        
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        

        
        let leftCloseAction = SKAction.moveBy(x: width/2-1, y: 0, duration: 1)
        let diveAction = SKAction.run {
            part1Left.node.zPosition = 0
            part1Right.node.zPosition = 0
        }
        let surfaceAction = SKAction.run {
            part1Left.node.zPosition = 2
            part1Right.node.zPosition = 2
        }
        let waitAction = SKAction.wait(forDuration: 1)
        let leftOpenAction = SKAction.moveBy(x: -width/2+1, y: 0, duration: 0)
        
        let rightCloseAction = SKAction.moveBy(x: -width/2, y: 0, duration: 1)
        let rightOpenAction = SKAction.moveBy(x: width/2, y: 0, duration: 0)
        
        let part1LeftAction = SKAction.repeatForever(SKAction.sequence([surfaceAction, leftCloseAction, diveAction, waitAction, leftOpenAction]))
        part1Left.node.run(part1LeftAction)
        let part1RightAction = SKAction.repeatForever(SKAction.sequence([rightCloseAction, waitAction, rightOpenAction]))
        part1Right.node.run(part1RightAction)
        
        let part2LeftAction = SKAction.repeatForever(SKAction.sequence([waitAction, leftOpenAction, leftCloseAction]))
        part2Left.node.run(part2LeftAction)
        let part2RightAction = SKAction.repeatForever(SKAction.sequence([waitAction, rightOpenAction, rightCloseAction]))
        part2Right.node.run(part2RightAction)
        
        
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
