//
//  ObstacleArranger.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class ObstacleArranger {
    var obstacleNodes:[SKNode] = []
    let obstacleTypes: [ObstacleType]
    let firstObstacleState: State
    weak var scene: SKScene?
    let startPointY: CGFloat
    let leftBorderX: CGFloat
    let rightBorderX: CGFloat
    let hPadding = CGFloat(10)
    let initialSpeed: CGFloat
    
    let obstacleMask: Mask
    
    
    let minYSpace: CGFloat = 150
    let maxYSpace: CGFloat = 300
    
    
    init(scene: SKScene,
         obstacleTypes:[ObstacleType],
         firstObstacleState: State,
         startPointY: CGFloat,
         leftBorderX:CGFloat,
         rightBorderX: CGFloat,
         obstacleMask: Mask,
         initialSpeed: CGFloat
         ) {
        self.scene = scene
        self.obstacleTypes = obstacleTypes
        self.firstObstacleState = firstObstacleState
//        self.startPointY = startPointY
        self .startPointY = 100
        self.leftBorderX = leftBorderX + hPadding
        self.rightBorderX = rightBorderX - hPadding
        self.obstacleMask = obstacleMask
        self.initialSpeed = initialSpeed
        
    }
    
    func arrangeOne(type: ObstacleType) -> Obstacle {
        
        var obstacle: Obstacle
        let width = rightBorderX-leftBorderX
        switch type {
        case .plank, .thinPlank, .squareStackPart:
            obstacle = RectObstacle(mask: obstacleMask, width: width, type: type)
        case .twoColorPlank:
            obstacle = MultiStatePlankObstacle(mask: obstacleMask, width: width)
        case .animatedTwoColorPlank:
            obstacle = MultiStateAnimatedPlankObstacle(mask: obstacleMask, width: width)
        case .square:
            obstacle = RectObstacle(mask: obstacleMask, width: SQUARE_OBSTACLE_SIDE, type: type)
        case .plankStack:
            obstacle = StackObstacle(mask: obstacleMask, width: width, states: [.first, .second].shuffled(), type: type)
        case .squareStack, .rotatingSquareStack:
            obstacle = StackObstacle(mask: obstacleMask, width: SQUARE_OBSTACLE_SIDE, states: [.first, .second].shuffled(), type: type)
        }
        
        obstacle.node.position = positionFor(obstacle, type: type)
        obstacle.velocity = initialSpeed
        scene?.addChild(obstacle.node)
        obstacle.onAddedToScene()
        
        obstacleNodes.append(obstacle.node)
        return obstacle
    }
    
    func arrange() {
        
        guard  obstacleTypes.count > 0 else {
            return
        }
        if let firstObstacle = arrangeOne(type: obstacleTypes[0]) as? RectObstacle {
            firstObstacle.state = firstObstacleState
        }

        for i in 1..<obstacleTypes.count {
            arrangeOne(type: obstacleTypes[i])
        }
        obstacleNodes = []
    }
    
    func positionFor(_ obstacle:Obstacle, type: ObstacleType) -> CGPoint{
        switch type{
        case .square, .squareStack, .rotatingSquareStack:
            return CGPoint(x: scene!.frame.midX-SQUARE_OBSTACLE_SIDE/2, y:nextY())
        default:
            return CGPoint(x: leftBorderX, y:nextY())
        }
        
    
    }
    
    func nextY() -> CGFloat {
        guard let lastPlaced = obstacleNodes.last else {
            return startPointY
        }
        return lastPlaced.frame.minY - CGFloat(randomBetween(Int(minYSpace), and: Int(maxYSpace)))
    }
    
    
}
