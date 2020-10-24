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
    let scene: SKScene
    let startPointY: CGFloat
    let leftBorderX: CGFloat
    let rightBorderX: CGFloat
    
    let obstacleMask: Mask
    
    
    let minYSpace: CGFloat = 150
    let maxYSpace: CGFloat = 300
    
    
    init(scene: SKScene, startPointY: CGFloat, leftBorderX:CGFloat, rightBorderX: CGFloat, obstacleMask: Mask) {
        self.scene = scene
        self.startPointY = startPointY
        self.leftBorderX = leftBorderX
        self.rightBorderX = rightBorderX
        self.obstacleMask = obstacleMask
    }
    
    func arrangeOne() {
        let obstacle = Obstacle(mask: obstacleMask)
        obstacle.state = State.random()
        obstacle.position = positionFor(obstacle)
        scene.addChild(obstacle)
        obstacles.append(obstacle)
    }
    
    func arrange() {
        for _ in 1...100 {
            arrangeOne()
        }
    }
    
    func positionFor(_ obstacle:Obstacle) -> CGPoint{
        guard !obstacles.contains(obstacle) else {
            return .zero
        }
        let left = leftBorderX
        let right = rightBorderX - obstacle.frame.width
        return CGPoint(x: CGFloat.random(in: left...right ), y:nextY())
    }
    
    func nextY() -> CGFloat {
        guard let lastPlaced = obstacles.last else {
            return startPointY
        }
        return lastPlaced.frame.minY - randomBetween(minYSpace, and: maxYSpace)
    }
    
    func remove(obstacle: Obstacle) {
        obstacle.removeFromParent()
    }
    
    
}
