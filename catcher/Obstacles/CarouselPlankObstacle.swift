//
//  CarouselPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 27.07.2022.
//

import Foundation
import SpriteKit

class CarouselPlankObstacle: MultiStateObstacle {
    let directionRight:Bool
    var shiftsCount = 0
    init(mask: Mask, states: [State], directionRight:Bool = false, type: ObstacleType) {
        let width = UIScreen.main.bounds.size.width
        self.directionRight = directionRight
        super.init()
        
        self.type = type
        name = String(describing: Obstacle.self)
        let partWidth = width/CGFloat(states.count-1)
        
        var i:CGFloat = 0;
        for state in states {
            let part = RectObstacle(mask: mask, width: partWidth-1, type: .plank)
            let x = directionRight ? (i-1)*partWidth : i*partWidth
            part.position = CGPoint(x:x, y: 0)
            part.state = state
            addChild(part)
            part.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.move(by: CGVector(dx: directionRight ? partWidth : -partWidth, dy: 0), duration: 3),
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
                            node.position = CGPoint(x: leftPart.position.x - partWidth, y:0)
                        } else {
                            guard let rightPart = self?.extremePart(right: true) else {
                                return
                            }
                            node.position = CGPoint(x:rightPart.position.x+partWidth, y:0)
                        }
                        
                    }
                    
                    self?.shiftsCount+=1
                })
            ])))
            i+=1
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
    
    func extremePart(right: Bool) -> RectObstacle?{
        let parts = parts() as! [RectObstacle]
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
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
