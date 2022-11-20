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
    let initialObstacleTypes: [ObstacleType]
    let obstacleTypesForTail: [ObstacleType]
    let levelCapacity: Int
    let firstObstacleState: State
    weak var scene: SKScene?
    let startPointY: CGFloat
    let leftBorderX: CGFloat
    let rightBorderX: CGFloat
    let hPadding = CGFloat(10)
    
    let obstacleMask: Mask
    
    let minYSpace: CGFloat = 150
    let maxYSpace: CGFloat = 200
    
    let colorScheme: ColorScheme
    
    init(scene: SKScene,
         initialObstacleTypes:[ObstacleType],
         obstacleTypesForTail: [ObstacleType],
         levelCapacity: Int,
         firstObstacleState: State,
         startPointY: CGFloat,
         leftBorderX:CGFloat,
         rightBorderX: CGFloat,
         obstacleMask: Mask,
         colorScheme: ColorScheme
         ) {
        self.scene = scene
        self.initialObstacleTypes = initialObstacleTypes
        self.obstacleTypesForTail = obstacleTypesForTail
        self.levelCapacity = levelCapacity
        self.firstObstacleState = firstObstacleState
        self.startPointY = startPointY
        self.leftBorderX = leftBorderX + hPadding
        self.rightBorderX = rightBorderX - hPadding
        self.obstacleMask = obstacleMask
        self.colorScheme = colorScheme
        
    }
    
    //TODO сделать ObstacleFactory
    func arrangeOne(type: ObstacleType, speed: CGFloat) -> Obstacle {
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
        case .pingPongPlank:
            obstacle = PingPongPlankObstacle(mask: obstacleMask, colorScheme: colorScheme, type: type)
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
        obstacle.velocity = speed
        scene?.addChild(obstacle.node)
        obstacle.onAddedToScene()
        
        lastObstacle = obstacle
        arrangedCount+=1
        return obstacle
    }
    
    func arrangeFirst(speed: CGFloat) -> [Obstacle]{
        guard  initialObstacleTypes.count > 0 else {
            return []
        }
        var obstacles: [Obstacle] = []
        let firstObstacle = arrangeOne(type: initialObstacleTypes[0], speed: speed)
        if let firstObstacle = firstObstacle as? RectObstacle {
            firstObstacle.state = firstObstacleState
        }
        obstacles.append(firstObstacle)

        var lastPlaced = firstObstacle
        while lastPlaced.node.position.y - startPointY + UIScreen.main.bounds.height > 0 && arrangedCount < initialObstacleTypes.count {
            lastPlaced = arrangeOne(type: initialObstacleTypes[arrangedCount-1], speed: speed)
            obstacles.append(lastPlaced)
        }
        return obstacles
    }
    
    func arrangeNext(speed: CGFloat) -> Obstacle? {
        guard let type = arrangedCount < initialObstacleTypes.count ? initialObstacleTypes[arrangedCount] : obstacleTypesForTail.randomElement() else {
            return nil
        }
        return arrangeOne(type: type, speed: speed)
    }
    
    func positionFor(_ obstacle:Obstacle, type: ObstacleType) -> CGPoint{
        let nextY = y(for: obstacle)
        switch type{
        case .arc, .arcStack, .animatedRing, .fragmentedRing(segmentsCount: _, rotationSpeed: _, isStacked: _, blinkInterval: _, acceleration: _):
            return CGPoint(x: scene!.frame.midX, y:nextY)
        case .carouselPlank, .pendulumPlank, .pingPongPlank:
            return CGPoint(x:0, y: nextY)
        default:
            return CGPoint(x: leftBorderX, y:nextY)
        }
    }
    
    func y(for obstacle: Obstacle) -> CGFloat {
        guard let lastPlaced = lastObstacle else {
            return startPointY
        }
        let nextY = lastPlaced.node.calculateAccumulatedFrame().minY - CGFloat(randomBetween(Int(minYSpace), and: Int(maxYSpace))) -  obstacle.node.calculateAccumulatedFrame().size.height/2
        return nextY
    }
}
    
