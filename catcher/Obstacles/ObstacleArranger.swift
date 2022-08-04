//
//  ObstacleArranger.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class ObstacleArranger {
    weak var lastObstacle: Obstacle?
    var arrangedCount:Int = 0
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
        case .twoStatePlank:
            obstacle = MultiStatePlankObstacle(mask: obstacleMask, width: width)
        case .pendulumPlank(swingSpeed: let swingSpeed):
            obstacle = PendulumPlankObstacle(mask: obstacleMask, swingSpeed: swingSpeed)
        case .plankStack:
            obstacle = StackObstacle(mask: obstacleMask, width: width, states: [.first, .second].shuffled(), type: type)
        case .animatedRing(segmentsCount: let segmentsCount, rotationSpeed: let rotationSpeed):
            let segmentsCount = Int(round(Double(segmentsCount) / 2.0)) * 2
            var states:[State] = []
            for i in 0..<segmentsCount {
                states.append(i % 2 == 0 ? .first : .second)
            }
            obstacle = RingObstacle(mask: obstacleMask, radius: CIRCLE_OBSTACLE_RADIUS, states: states, type: type, rotationSpeed: rotationSpeed)
        case .carouselPlank(partsCount: let partsCount, carouselSpeed: let carouselSpeed, directionRight: let directionRight):
            let partsCount = Int(round(Double(partsCount) / 2.0)) * 2
            obstacle = CarouselPlankObstacle(mask: obstacleMask, partsCount: partsCount, directionRight: directionRight, type:type, carouselSpeed: carouselSpeed)
        case .fragmentedRing(segmentsCount: let segmentsCount, rotationSpeed: let rotationSpeed):
            let segmentsCount = Int(round(Double(segmentsCount) / 2.0)) * 2
            var states:[State] = []
            for i in 0..<segmentsCount {
                states.append(i % 2 == 0 ? .first : .second)
            }
            obstacle = FragmentedRingObstacle(mask: obstacleMask, radius: 96, states: states, type: type, rotationSpeed: rotationSpeed)
        default:
            fatalError("can't arrange this obstacle with no parent")
        }

        
        obstacle.node.position = positionFor(obstacle, type: type)
        obstacle.velocity = initialSpeed
        scene?.addChild(obstacle.node)
        obstacle.onAddedToScene()
        
        lastObstacle = obstacle
        arrangedCount+=1
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
            lastPlaced = arrangeOne(type: obstacleTypes[arrangedCount])
        }
    }
    
    func arrangeNext() {
        guard arrangedCount < obstacleTypes.count else {
            return
        }
        _ = arrangeOne(type: obstacleTypes[arrangedCount])
    }
    
    func arrangeAll() {
        for i in arrangedCount..<obstacleTypes.count {
            _ = arrangeOne(type: obstacleTypes[i])
        }
    }
    
    func positionFor(_ obstacle:Obstacle, type: ObstacleType) -> CGPoint{
        switch type{
        case .animatedRing, .fragmentedRing(segmentsCount: _, rotationSpeed: _):
            return CGPoint(x: scene!.frame.midX, y:nextY())
        case .carouselPlank, .pendulumPlank:
            return CGPoint(x:0, y: nextY())
        default:
            return CGPoint(x: leftBorderX, y:nextY())
        }
        
    
    }
    
    func nextY() -> CGFloat {
        guard let lastPlaced = lastObstacle else {
            return startPointY
        }
        return lastPlaced.node.calculateAccumulatedFrame().minY - CGFloat(randomBetween(Int(minYSpace), and: Int(maxYSpace)))
    }
    
    
}
    
