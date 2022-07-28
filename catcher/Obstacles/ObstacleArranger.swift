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
    
    
    let minYSpace: CGFloat = 200
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
        self.startPointY = startPointY
        self.leftBorderX = leftBorderX + hPadding
        self.rightBorderX = rightBorderX - hPadding
        self.obstacleMask = obstacleMask
        self.initialSpeed = initialSpeed
        
    }
    
    func arrangeOne(type: ObstacleType) -> Obstacle {
        
        var obstacle: Obstacle
        let width = rightBorderX-leftBorderX
        switch type {
        case .plank, .thinPlank:
            obstacle = RectObstacle(mask: obstacleMask, width: width, type: type)
        case .twoColorPlank:
            obstacle = MultiStatePlankObstacle(mask: obstacleMask, width: width)
        case .animatedTwoColorPlank:
            obstacle = MultiStateAnimatedPlankObstacle(mask: obstacleMask)
        case .plankStack:
            obstacle = StackObstacle(mask: obstacleMask, width: width, states: [.first, .second].shuffled(), type: type)
        case .fourSegmentAnimatedRing:
            obstacle = MultistateRingObstacle(mask: obstacleMask, radius: CIRCLE_OBSTACLE_RADIUS, states: [.first, .second, .first, .second], type: type, rotationVelocity: 2)
        case .carousel2:
            obstacle = CarouselPlankObstacle(mask: obstacleMask, states:  [.first, .second], type:.carousel2)
        }
        
        obstacle.node.position = positionFor(obstacle, type: type)
        obstacle.velocity = initialSpeed
        scene?.addChild(obstacle.node)
        obstacle.onAddedToScene()
        
        obstacleNodes.append(obstacle.node)
        return obstacle
    }
    
    func arrangeFirst() {
        
        guard  obstacleTypes.count > 0 else {
            return
        }
        
        let firstObstacle = arrangeOne(type: obstacleTypes[0])
        if let firstObstacle = firstObstacle as? RectObstacle {
            firstObstacle.state = firstObstacleState
        }

        var lastPlaced = firstObstacle
        while lastPlaced.node.position.y - startPointY + UIScreen.main.bounds.height > 0 {
            lastPlaced = arrangeOne(type: obstacleTypes[obstacleNodes.count])
        }
    }
    
    func positionFor(_ obstacle:Obstacle, type: ObstacleType) -> CGPoint{
        switch type{
        case .fourSegmentAnimatedRing:
            return CGPoint(x: scene!.frame.midX, y:nextY())
        case .carousel2, .animatedTwoColorPlank:
            return CGPoint(x:0, y: nextY())
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
    
    func arrangeNext() {
        guard obstacleNodes.count < obstacleTypes.count else {
            return
        }
        arrangeOne(type: obstacleTypes[obstacleNodes.count])
    }
}
