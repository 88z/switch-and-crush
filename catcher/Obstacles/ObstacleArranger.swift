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
    let hPadding = CGFloat(0)
    
    let obstacleMask: Mask
    
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
                                    colorScheme: colorScheme,
                                    type: type)
        case .brick:
            obstacle = RectObstacle(mask: obstacleMask, width: STONE_OBSTACLE_HEIGHT, colorScheme: colorScheme, type: type)
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
                                    radius: CIRCLE_OBSTACLE_MEDIUM_RADIUS,
                                    colorScheme: colorScheme,
                                    type: type)
        case .carouselPlank:
            obstacle = CarouselPlankObstacle(mask: obstacleMask,
                                             colorScheme: colorScheme,
                                             type:type)
        case .fragmentedRing:
            obstacle = FragmentedRingObstacle(mask: obstacleMask,
                                              radius: FRAGMENTED_RING_RADIUS,
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
        case .gatePlank:
            obstacle = GatePlankObstacle(mask: obstacleMask, colorScheme: colorScheme, type: type)
        case .ringWithBrick:
            obstacle = RingWithStoneObstacle(mask: obstacleMask,
                                             radius: CIRCLE_OBSTACLE_MEDIUM_RADIUS,
                                             colorScheme: colorScheme,
                                             type: type,
                                             stoneType: .brick(state: .random(),
                                                               blinkInterval: 0,
                                                               spaceAfter: 0,
                                                               acceleration: 0))
        case .doubleRing(outerSegmentsCount: _,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: _,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: _,
                         innerIsStacked: _,
                         outerDirectionClockwise: _,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: _,
                         acceleration: _):
            obstacle = RingWithStoneObstacle(mask: obstacleMask,
                                             radius: CIRCLE_OBSTACLE_BIG_RADIUS,
                                             colorScheme: colorScheme,
                                             type: type,
                                             stoneType: .animatedRing(segmentsCount: innerSegmentsCount,
                                                                      rotationSpeed: innerRotationSpeed,
                                                                      directionClockwise: innerDirectionClockwise,
                                                                      isStacked: false,
                                                                      spaceAfter: 0,
                                                                      acceleration: 0))
        case .doubleRingWithBrick(outerSegmentsCount: _,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: _,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: _,
                         innerIsStacked: _,
                         outerDirectionClockwise: _,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: _,
                         acceleration: _):
            obstacle = RingWithStoneObstacle(mask: obstacleMask,
                                             radius: CIRCLE_OBSTACLE_BIG_RADIUS,
                                             colorScheme: colorScheme,
                                             type: type,
                                             stoneType: .ringWithBrick(segmentsCount: innerSegmentsCount, rotationSpeed: innerRotationSpeed, directionClockwise: innerDirectionClockwise, isStacked: false, spaceAfter: 0, acceleration: 0))
        
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
            lastPlaced = arrangeOne(type: initialObstacleTypes[arrangedCount], speed: speed)
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
        case .arc, .arcStack, .animatedRing, .doubleRing, .doubleRingWithBrick, .ringWithBrick, .fragmentedRing(segmentsCount: _,
                                                             rotationSpeed: _,
                                                             directionClockwise: _,
                                                             isStacked: _,
                                                             blinkInterval: _,
                                                             spaceAfter: _,
                                                             acceleration: _):
            return CGPoint(x: scene!.frame.midX, y:nextY)
        case .carouselPlank, .pendulumPlank, .pingPongPlank:
            return CGPoint(x:0, y: nextY)
        case .brick:
            return CGPoint(x: scene!.frame.midX-STONE_OBSTACLE_HEIGHT/2, y:nextY)
        default:
            return CGPoint(x: leftBorderX, y:nextY)
        }
    }
    
    func y(for obstacle: Obstacle) -> CGFloat {
        
        
        guard let lastPlaced = lastObstacle else {
            return startPointY
        }
        
        let zRotation = lastPlaced.node.zRotation
        switch lastPlaced.type {
        case .animatedRing(segmentsCount: _,
                           rotationSpeed: _,
                           directionClockwise: _,
                           isStacked: _,
                           spaceAfter: _,
                           acceleration: _):
            lastPlaced.node.zRotation = 0
        default:
            break
        }
        
        let nextY = lastPlaced.node.calculateAccumulatedFrame().minY - CGFloat(lastPlaced.spaceAfter) -  obstacle.node.calculateAccumulatedFrame().size.height/2
        lastPlaced.node.zRotation = zRotation
        return nextY
    }
}
    
