//
//  TwoPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 11.07.2022.
//

import Foundation
import SpriteKit

class MultiStatePlankObstacle: MultiStateObstacle {
    
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    init(mask:Mask, width: CGFloat, partSizes:[CGFloat]) {
        super.init()
        var nextX:CGFloat = 0
        var nextState = State.random()
        for partSize in partSizes {
            let partWidth = partSize*width
            let obstacle = RectObstacle(mask: mask, width: partWidth, type: .plank)
            obstacle.state = nextState
            nextState = State.nextState(for: nextState)
            obstacle.position = CGPoint(x: nextX, y: 0)
            addChild(obstacle)
            nextX+=partWidth+1
        }
        name = String(describing: Obstacle.self)
    }
    
   override convenience init(mask: Mask, width: CGFloat) {
        var leftPartSize = CGFloat(randomBetween(25, and: 40))/100
        if Bool.random() {
            leftPartSize = 1-leftPartSize
        }
        let rightPartSize = 1-leftPartSize
        
        self.init(mask: mask, width: width, partSizes: [leftPartSize, rightPartSize])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
