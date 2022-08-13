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
    
    let colorScheme: ColorScheme
    
    init(scene: SKScene,
         obstacleTypes:[ObstacleType],
         firstObstacleState: State,
         startPointY: CGFloat,
         leftBorderX:CGFloat,
         rightBorderX: CGFloat,
         obstacleMask: Mask,
         initialSpeed: CGFloat,
         colorScheme: ColorScheme
         ) {
        self.scene = scene
        self.obstacleTypes = obstacleTypes
        self.firstObstacleState = firstObstacleState
        self.startPointY = startPointY
        self.leftBorderX = leftBorderX + hPadding
        self.rightBorderX = rightBorderX - hPadding
        self.obstacleMask = obstacleMask
        self.initialSpeed = initialSpeed
        self.colorScheme = colorScheme
        
    }
    
    //TODO сделать ObstacleFactory
    //TODO брать параметры из type
    func arrangeOne(type: ObstacleType) -> Obstacle {
        
        var obstacle: Obstacle
        let width = rightBorderX-leftBorderX
        switch type {
        case .plank, .thinPlank:
            obstacle = RectObstacle(mask: obstacleMask,
                                    width: width,
                                    state:.random(),
                                    colorScheme: colorScheme,
                                    type: type)
        case .twoStatePlank:
            obstacle = MultiStatePlankObstacle(mask: obstacleMask, width: width, colorScheme: colorScheme, type: type)
        case .pendulumPlank:
            obstacle = PendulumPlankObstacle(mask: obstacleMask, colorScheme: colorScheme, type: type)
        case .plankStack:
            obstacle = StackObstacle(mask: obstacleMask,
                                     width: width,
                                     states: [.first, .second].shuffled(),
                                     colorScheme: colorScheme,
                                     type: type)
        case .animatedRing:
            obstacle = RingObstacle(mask: obstacleMask,
                                    radius: CIRCLE_OBSTACLE_RADIUS,
                                    colorScheme: colorScheme,
                                    type: type)
        case .carouselPlank:
            obstacle = CarouselPlankObstacle(mask: obstacleMask,
                                             colorScheme: colorScheme,
                                             type:type)
        case .fragmentedRing:
            obstacle = FragmentedRingObstacle(mask: obstacleMask,
                                              radius: 96,
                                              type: type,
                                              colorScheme: colorScheme)
        case .arc:
            obstacle = ArcObstacle(mask: obstacleMask,
                                   state: State.random(),
                                   center: .zero,
                                   radius: 96,
                                   startAngle: 0,
                                   endAngle: CGFloat.pi,
                                   colorScheme: colorScheme,
                                   type: type)
        case .arcStack:
            obstacle = StackArcObstacle(mask: obstacleMask,
                                        states: [.first, .second],
                                        center: .zero,
                                        radius: 96,
                                        startAngle: 0,
                                        endAngle: CGFloat.pi,
                                        colorScheme: colorScheme,
                                        type: type)
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
        while lastPlaced.node.position.y - startPointY + UIScreen.main.bounds.height > 0 && arrangedCount < obstacleTypes.count {
            lastPlaced = arrangeOne(type: obstacleTypes[arrangedCount-1])
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
        case .arc, .arcStack, .animatedRing, .fragmentedRing(segmentsCount: _, rotationSpeed: _, isStacked: _, blinkInterval: _):
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
    
