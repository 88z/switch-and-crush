//
//  MultistateAnimatedPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class MultiStateAnimatedPlankObstacle: MultiStateObstacle {
    
    let cropNode: SKCropNode
    override init(mask: Mask, width: CGFloat) {
        var leftPartState = State.first
        var rightPartState = State.second
        if Bool.random() {
            leftPartState = State.second
            rightPartState = State.first
        }
        
        let leftObstacle = RectObstacle(mask: mask, width: width, type: .plank)
        leftObstacle.position = CGPoint(x: -width, y: 0)
        leftObstacle.state = leftPartState
        let rightObstacle = RectObstacle(mask: mask, width: width, type: .plank)
        rightObstacle.position = CGPoint(x: 1, y: 0)
        rightObstacle.state = rightPartState
        
        let height = rightObstacle.frame.size.height
        let duration:TimeInterval = 3

        let moveRightAction = SKAction.moveBy(x: width, y:0, duration: duration)
        let moveLeftAction = SKAction.moveBy(x: -width, y:0, duration: duration)
        
        let action = SKAction.repeatForever(SKAction.sequence([moveRightAction, moveLeftAction]))
        
        let maskShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: 21))
        maskShapeNode.strokeColor = .white
        maskShapeNode.fillColor = .white
        
        cropNode = SKCropNode()
        cropNode.maskNode = maskShapeNode
        cropNode.addChild(leftObstacle)
        cropNode.addChild(rightObstacle)
        
        super.init()
        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.collisionBitMask = 0b0000
        physicsBody?.contactTestBitMask = 0b0000
        physicsBody?.categoryBitMask = 0b0000
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        addChild(cropNode)
        leftObstacle.run(action)
        rightObstacle.run(action)
        
    }
    
    override func parts() -> [Obstacle] {
        return cropNode[String(describing: Obstacle.self)] as! [Obstacle]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
