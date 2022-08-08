//
//  PlankStackObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.07.2022.
//

import Foundation
import SpriteKit

class StackObstacle: MultiStateObstacle {
    
    override var isSolid:Bool {
        get {
            return true
        }
    }

    init(mask:Mask, width: CGFloat, states: [State], colorScheme: ColorScheme, type: ObstacleType) {
        super.init(colorScheme: colorScheme)
        name = String(describing: Obstacle.self)
        self.type = type
        
        let partType: ObstacleType = .thinPlank
        
        var nextY:CGFloat = 0
        for state in states {
            let obstacle = RectObstacle(mask: mask, width: width, state: state, colorScheme: colorScheme, type: partType)
            obstacle.state = state
            addChild(obstacle)
            obstacle.position = CGPoint(x: 0, y: nextY)
            nextY = nextY + obstacle.frame.size.height - 2

        }
        
        
    }
    
    override func parts() -> [Obstacle] {
        return self[String(describing: Obstacle.self)] as! [Obstacle]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
