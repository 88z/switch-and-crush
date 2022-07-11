//
//  ObstacleArranger.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 21.10.2020.
//

import Foundation
import SpriteKit

class ObstacleArranger {
    var obstacles:[SKNode] = []
    let obstacleCount: Int
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
         obstacleCount:Int,
         firstObstacleState: State,
         startPointY: CGFloat,
         leftBorderX:CGFloat,
         rightBorderX: CGFloat,
         obstacleMask: Mask,
         initialSpeed: CGFloat
         ) {
        self.scene = scene
        self.obstacleCount = obstacleCount
        self.firstObstacleState = firstObstacleState
        self.startPointY = startPointY
        self.leftBorderX = leftBorderX + hPadding
        self.rightBorderX = rightBorderX - hPadding
        self.obstacleMask = obstacleMask
        self.initialSpeed = initialSpeed
        
    }
    
    func _arrangeOne(with state: State) {
        let obstacle = PlankObstacle(mask: obstacleMask, width: rightBorderX-leftBorderX)
        obstacle.state = state
        obstacle.position = positionFor(obstacle)
        obstacle.velocity = initialSpeed
        scene?.addChild(obstacle)
        obstacles.append(obstacle)
    }
    
    func arrangeOne(with state: State) {
        let obstacle = MultiStatePlankObstacle.twoPartsPlankObstacle(mask: obstacleMask, width: rightBorderX-leftBorderX)
        obstacle.position = positionFor(obstacle)
        obstacle.velocity = initialSpeed
        scene?.addChild(obstacle)
        obstacles.append(obstacle)
    }
    
    func arrange() {
        guard  obstacleCount > 0 else {
            return
        }
        arrangeOne(with: firstObstacleState)
        guard  obstacleCount > 1 else {
            return
        }
        for _ in 1..<obstacleCount {
            arrangeOne(with: State.random())
        }
        obstacles = []
    }
    
    func positionFor(_ obstacle:Obstacle) -> CGPoint{
        return CGPoint(x: leftBorderX, y:nextY())
    }
    
    func nextY() -> CGFloat {
        guard let lastPlaced = obstacles.last else {
            return startPointY
        }
        return lastPlaced.frame.minY - randomBetween(minYSpace, and: maxYSpace)
    }
    
    
}
