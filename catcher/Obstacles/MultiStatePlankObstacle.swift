//
//  TwoPlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 11.07.2022.
//

import Foundation
import SpriteKit

class MultiStatePlankObstacle: MultiStateObstacle {
    
    var isStacked: Bool
    
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    init(mask:Mask, width: CGFloat, partSizes:[CGFloat], colorScheme: ColorScheme, type: ObstacleType) {
        
        var blinkInterval: TimeInterval = 0
        var isStacked = false
        switch type {
        case .twoStatePlank(isStacked: let _isStacked, blinkInterval: let _blinkInterval):
            blinkInterval = _blinkInterval
            isStacked = _isStacked
        default:
            assertionFailure("incorrect type for " + String(describing: MultiStateObstacle.self))
        }
        self.isStacked = isStacked
        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval)
        var nextX:CGFloat = 0
        var state = State.random()
        for partSize in partSizes {
            let partWidth = partSize*width
            let obstacle = initPart(mask: mask, state: state, width: partWidth)
            state = State.nextState(for: state)
            obstacle.node.position = CGPoint(x: nextX, y: 0)
            addChild(obstacle.node)
            nextX+=partWidth+1
        }
        name = String(describing: Obstacle.self)
    }
    
    convenience init(mask: Mask, width: CGFloat, colorScheme: ColorScheme, type: ObstacleType) {
        var leftPartSize = CGFloat(randomBetween(25, and: 40))/100
        if Bool.random() {
            leftPartSize = 1-leftPartSize
        }
        let rightPartSize = 1-leftPartSize
        
        self.init(mask: mask, width: width, partSizes: [leftPartSize, rightPartSize], colorScheme: colorScheme, type: type)
    }
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> Obstacle{
        if isStacked {
            return StackObstacle(mask: mask, width: width, states: [state, State.nextState(for: state)], colorScheme: colorScheme, type: .plankStack(blinkInterval: blinkInterval))
        } else {
            let part = RectObstacle(mask: mask, width: width, state: state, colorScheme: colorScheme, type: .plank(blinkInterval: blinkInterval))
            return part
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
