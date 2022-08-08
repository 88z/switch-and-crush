//
//  StackArcObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 07.08.2022.
//

import Foundation
import SpriteKit

class StackArcObstacle: MultiStateObstacle {
    override var isSolid:Bool {
        get {
            return true
        }
    }
    
    init(mask:Mask, states: [State], center:CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat,colorScheme: ColorScheme, type: ObstacleType) {
        super.init(colorScheme: colorScheme)
        name = String(describing: Obstacle.self)
        self.type = type
        
        let partType: ObstacleType = .arc
        
        var nextRadius:CGFloat = radius
        for state in states {
            let obstacle = ArcObstacle(mask: mask, state: state, center: center, radius: nextRadius, startAngle: startAngle, endAngle: endAngle, colorScheme: colorScheme, type: partType)
            obstacle.state = state
            addChild(obstacle)
            obstacle.position = CGPoint(x: 0, y: .zero)
            nextRadius = nextRadius - ARC_OBSTACLE_THICKNESS - 1
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func parts() -> [Obstacle] {
        return self[String(describing: Obstacle.self)] as! [Obstacle]
    }
}
