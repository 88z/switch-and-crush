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
        
        var blinkInterval: TimeInterval = 0
        var acceleration: CGFloat = 0
        var spaceAfter: CGFloat = 0
        switch type {
        case .plankStack(blinkInterval: let _blinkInterval, spaceAfter: let _spaceAfter, acceleration: let _acceleration):
            blinkInterval = _blinkInterval
            acceleration = _acceleration
            spaceAfter = _spaceAfter
        default:
            assertionFailure("incorrect type for " + String(describing: StackObstacle.self))
        }

        super.init(colorScheme: colorScheme,
                   blinkInterval: blinkInterval,
                   spaceAfter: spaceAfter,
                   acceleration: acceleration)
        name = String(describing: Obstacle.self)
        self.type = type
        
        var nextY:CGFloat = 0
        for state in states {
            let partType: ObstacleType = .thinPlank(state: state, blinkInterval: blinkInterval, spaceAfter: 0, acceleration: acceleration)
            let obstacle = RectObstacle(mask: mask, width: width, colorScheme: colorScheme, type: partType)
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
