//
//  PlankStackObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.07.2022.
//

import Foundation
import SpriteKit

class StackObstacle: MultiStateObstacle {
    init(mask:Mask, width: CGFloat, states: [State], type: ObstacleType) {
        super.init()
        var i = 0
        var nextY:CGFloat = 0
        
        let partType: ObstacleType
        
        switch type {
        case .plankStack:
            partType = .thinPlank
        case .squareStack:
            partType = .squareStackPart
        default:
            partType = .thinPlank
        }
        
        for state in states {
            let obstacle = RectObstacle(mask: mask, width: width, type: partType)
            obstacle.state = state
            obstacle.position = CGPoint(x: 0, y: nextY)
            addChild(obstacle)
            nextY = nextY + obstacle.frame.size.height - 2
            i+=1
        }
        name = String(describing: Obstacle.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
