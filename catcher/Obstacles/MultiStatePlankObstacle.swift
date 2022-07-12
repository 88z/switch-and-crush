//
//  TwoPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 11.07.2022.
//

import Foundation
import SpriteKit

class MultiStatePlankObstacle: MultiStateObstacle {
    init(mask:Mask, width: CGFloat, states: [State], partSizes:[CGFloat]) {
        guard states.count == partSizes.count else {
            fatalError("Multiplank Obstacles Constructor Error: state and partSizes must have equal size")
        }
        super.init()
        var i = 0
        var nextX:CGFloat = 0
        for state in states {
            let partWidth = partSizes[i]*width
            let obstacle = PlankObstacle(mask: mask, width: partWidth)
            obstacle.state = state
            obstacle.position = CGPoint(x: nextX, y: 0)
            addChild(obstacle)
            nextX+=partWidth+1
            i+=1
        }
    }
    
    required convenience init(mask: Mask, width: CGFloat) {
        var leftPartSize = 0.25
        if Bool.random() {
            leftPartSize = 0.75
        }
        let rightPartSize = 1-leftPartSize
        
        var leftPartState = State.first
        var rightPartState = State.second
        if Bool.random() {
            leftPartState = State.second
            rightPartState = State.first
        }
        
        self.init(mask: mask, width: width, states: [leftPartState, rightPartState], partSizes: [leftPartSize, rightPartSize])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
