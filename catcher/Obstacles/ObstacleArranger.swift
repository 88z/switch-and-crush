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
        case .solidRing:
            obstacle = RingObstacle(mask: obstacleMask,
                                    radius: SOLID_RING_RADIUS,
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
        case .ringWithBrick(segmentsCount: let _segmentsCount,
                            rotationSpeed: let _rotationSpeed,
                            directionClockwise: let _directionClockwise,
                            isStacked: let _isStacked,
                            spaceAfter: let _spaceAfter,
                            acceleration: let _acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                             outerRadius: SOLID_RING_WITH_BRICK_RADIUS,
                                             innerRadius: 0,
                                             colorScheme: colorScheme,
                                              outerType: .solidRing(segmentsCount: _segmentsCount,
                                                                       rotationSpeed: _rotationSpeed,
                                                                       directionClockwise: _directionClockwise,
                                                                       isStacked: _isStacked,
                                                                       spaceAfter: _spaceAfter,
                                                                       acceleration: _acceleration),
                                             innerType: .brick(state: .random(),
                                                               blinkInterval: 0,
                                                               spaceAfter: 0,
                                                               acceleration: 0),
                                              type: type)
        case .fragmentedRingWithBrick(segmentsCount: let _segmentsCount,
                            rotationSpeed: let _rotationSpeed,
                            directionClockwise: let _directionClockwise,
                            isStacked: let _isStacked,
                            spaceAfter: let _spaceAfter,
                            acceleration: let _acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                             outerRadius: SOLID_RING_RADIUS,
                                             innerRadius: 0,
                                             colorScheme: colorScheme,
                                              outerType: .fragmentedRing(segmentsCount: _segmentsCount,
                                                                                  rotationSpeed: _rotationSpeed,
                                                                                  directionClockwise: _directionClockwise,
                                                                                  isStacked: _isStacked,
                                                                                  spaceAfter: _spaceAfter,
                                                                                  acceleration: _acceleration),
                                             innerType: .brick(state: .random(),
                                                               blinkInterval: 0,
                                                               spaceAfter: 0,
                                                               acceleration: 0),
                                              type: type)
        case .doubleRing(outerSegmentsCount: let outerSegmentsCount,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: let outerRotationSpeed,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: let outerIsStacked,
                         innerIsStacked: let innerIsStacked,
                         outerDirectionClockwise: let outerDirectionClockwise,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: let spaceAfter,
                         acceleration: let acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                              outerRadius: SOLID_RING_RADIUS_OUTER,
                                              innerRadius: SOLID_RING_WITH_BRICK_RADIUS,
                                              colorScheme: colorScheme,
                                              outerType: .solidRing(segmentsCount: outerSegmentsCount,
                                                                       rotationSpeed: outerRotationSpeed,
                                                                       directionClockwise: outerDirectionClockwise,
                                                                       isStacked: outerIsStacked,
                                                                       spaceAfter: spaceAfter,
                                                                       acceleration: acceleration),
                                              innerType: .solidRing(segmentsCount: innerSegmentsCount,
                                                                       rotationSpeed: innerRotationSpeed,
                                                                       directionClockwise: innerDirectionClockwise,
                                                                       isStacked: innerIsStacked,
                                                                       spaceAfter: 0,
                                                                       acceleration: acceleration),
                                              type: type)
        case .doubleRingWithBrick(outerSegmentsCount: let outerSegmentsCount,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: let outerRotationSpeed,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: let outerIsStacked,
                         innerIsStacked: let innerIsStacked,
                         outerDirectionClockwise: let outerDirectionClockwise,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: let spaceAfter,
                         acceleration: let acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                              outerRadius: SOLID_RING_RADIUS_OUTER,
                                              innerRadius: SOLID_RING_RADIUS,
                                              colorScheme: colorScheme,
                                              outerType: .solidRing(segmentsCount: outerSegmentsCount,
                                                                       rotationSpeed: outerRotationSpeed,
                                                                       directionClockwise: outerDirectionClockwise,
                                                                       isStacked: outerIsStacked,
                                                                       spaceAfter: spaceAfter,
                                                                       acceleration: acceleration),
                                              innerType: .ringWithBrick(segmentsCount: innerSegmentsCount,
                                                                        rotationSpeed: innerRotationSpeed,
                                                                        directionClockwise: innerDirectionClockwise,
                                                                        isStacked: innerIsStacked,
                                                                        spaceAfter: 0,
                                                                        acceleration: acceleration),
                                              type: type)
        case .fragmentedDoubleRing(outerSegmentsCount: let outerSegmentsCount,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: let outerRotationSpeed,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: let outerIsStacked,
                         innerIsStacked: let innerIsStacked,
                         outerDirectionClockwise: let outerDirectionClockwise,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: let spaceAfter,
                         acceleration: let acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                              outerRadius: FRAGMENTED_RING_RADIUS_OUTER,
                                              innerRadius: FRAGMENTED_RING_RADIUS,
                                              colorScheme: colorScheme,
                                              outerType: .fragmentedRing(segmentsCount: outerSegmentsCount,
                                                                       rotationSpeed: outerRotationSpeed,
                                                                       directionClockwise: outerDirectionClockwise,
                                                                       isStacked: outerIsStacked,
                                                                       spaceAfter: spaceAfter,
                                                                       acceleration: acceleration),
                                              innerType: .fragmentedRing(segmentsCount: innerSegmentsCount,
                                                                       rotationSpeed: innerRotationSpeed,
                                                                       directionClockwise: innerDirectionClockwise,
                                                                       isStacked: innerIsStacked,
                                                                       spaceAfter: 0,
                                                                       acceleration: acceleration),
                                              type: type)
        case .fragmentedDoubleRingWithBrick(outerSegmentsCount: let outerSegmentsCount,
                         innerSegmentsCount: let innerSegmentsCount,
                         outerRotationSpeed: let outerRotationSpeed,
                         innerRotationSpeed: let innerRotationSpeed,
                         outerIsStacked: let outerIsStacked,
                         innerIsStacked: let innerIsStacked,
                         outerDirectionClockwise: let outerDirectionClockwise,
                         innerDirectionClockwise: let innerDirectionClockwise,
                         spaceAfter: let spaceAfter,
                         acceleration: let acceleration):
            obstacle = InnerOuterRingObstacle(mask: obstacleMask,
                                              outerRadius: FRAGMENTED_RING_RADIUS_OUTER,
                                              innerRadius: FRAGMENTED_RING_RADIUS,
                                              colorScheme: colorScheme,
                                              outerType: .fragmentedRing(segmentsCount: outerSegmentsCount,
                                                                       rotationSpeed: outerRotationSpeed,
                                                                       directionClockwise: outerDirectionClockwise,
                                                                       isStacked: outerIsStacked,
                                                                       spaceAfter: spaceAfter,
                                                                       acceleration: acceleration),
                                              innerType: .fragmentedRingWithBrick(segmentsCount: innerSegmentsCount,
                                                                       rotationSpeed: innerRotationSpeed,
                                                                       directionClockwise: innerDirectionClockwise,
                                                                       isStacked: innerIsStacked,
                                                                       spaceAfter: 0,
                                                                       acceleration: acceleration),
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
        case .arc,
                .fragmentedRingWithBrick,
                .fragmentedDoubleRing,
                .arcStack,
                .solidRing,
                .doubleRing,
                .doubleRingWithBrick,
                .ringWithBrick,
                .fragmentedDoubleRingWithBrick,
                .fragmentedRing:
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
        case .solidRing:
            lastPlaced.node.zRotation = 0
        default:
            break
        }
        
        let nextY = lastPlaced.node.calculateAccumulatedFrame().minY - CGFloat(lastPlaced.spaceAfter) -  obstacle.node.calculateAccumulatedFrame().size.height/2
        lastPlaced.node.zRotation = zRotation
        return nextY
    }
}
    
