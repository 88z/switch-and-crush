//
//  StonedRingObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 29.01.2023.
//

import Foundation
import SpriteKit

class InnerOuterRingObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return false
        }
    }
    
    private let outerRadius: CGFloat
    private let innerRadius: CGFloat
    private let outerSegmentsCount: Int
    private let outerRotationSpeed: Speed
    private let outerDirectionClockwise: Bool
    private let outerIsStacked: Bool
    
    private var center: CGPoint {
        get {
            return CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
    private let innerType: ObstacleType
    
    
    init (mask: Mask, outerRadius: CGFloat, innerRadius: CGFloat, colorScheme: ColorScheme, outerType: ObstacleType, innerType: ObstacleType, type: ObstacleType) {
        
        var outerIsStacked = false
        var outerSegmentsCount = 0
        var acceleration = 0
        var outerRotationSpeed: Speed = .none
        var outerDirectionClockwise = true
        var spaceAfter: CGFloat = 0
        switch outerType {
        case .animatedRing(segmentsCount: let _segmentsCount,
                                rotationSpeed: let _rotationSpeed,
                                directionClockwise: let _directionClockwise,
                                isStacked: let _isStacked,
                                spaceAfter: let _spaceAfter,
                                acceleration: let _acceleration):
                 outerIsStacked = _isStacked
                 outerSegmentsCount = Int(round(Double(_segmentsCount) / 2.0)) * 2
                 outerRotationSpeed = _rotationSpeed
                 acceleration = _acceleration
                 spaceAfter = _spaceAfter
                 outerDirectionClockwise = _directionClockwise
        default:
            assertionFailure("incorrect outer type for " + String(describing: InnerOuterRingObstacle.self))
        }

        self.outerRadius = outerRadius
        self.innerRadius = innerRadius
        self.outerSegmentsCount = outerSegmentsCount
        self.outerRotationSpeed = outerRotationSpeed
        self.outerIsStacked = outerIsStacked
        self.outerDirectionClockwise = outerDirectionClockwise
        self.innerType = innerType
        super.init(colorScheme: colorScheme, blinkInterval: 0, spaceAfter: spaceAfter, acceleration: acceleration)
        self.type = type
        initParts(mask: mask)
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(circleOfRadius: outerRadius, center: center)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.density = 0
        physicsBody?.setZeroMask()
        
    }
    
    private func initParts(mask:Mask) {
        let ringObstacleType = ObstacleType.animatedRing(segmentsCount: outerSegmentsCount,
                                                         rotationSpeed: outerRotationSpeed,
                                                         directionClockwise: outerDirectionClockwise,
                                                         isStacked: outerIsStacked,
                                                         spaceAfter: 0,
                                                         acceleration: acceleration)
        addChild(RingObstacle(mask: mask, radius: outerRadius, colorScheme: colorScheme, type: ringObstacleType))
        
        guard let stone = initStone(mask: mask) else {
            return
        }
        addChild(stone.node)
    }
    
    private func initStone(mask: Mask) -> Obstacle? {
        switch innerType {
        case .brick:
            let stone =  RectObstacle(mask: mask, width: STONE_OBSTACLE_HEIGHT, colorScheme: colorScheme, type: innerType)
            stone.node.position = CGPoint(x: -STONE_OBSTACLE_HEIGHT/2, y: -STONE_OBSTACLE_HEIGHT/2)
            return stone
        case .animatedRing:
            let stone = RingObstacle(mask: mask, radius: CIRCLE_OBSTACLE_MEDIUM_RADIUS, colorScheme: colorScheme, type: innerType)
            return stone
        case .ringWithBrick(segmentsCount: let _segmentsCount, rotationSpeed: let _rotationSpeed, directionClockwise: let _directionClockwise, isStacked: let _isStacked, spaceAfter: _, acceleration: _):
            let stone = InnerOuterRingObstacle(mask: mask,
                                               outerRadius: innerRadius,
                                               innerRadius: 0,
                                               colorScheme: colorScheme,
                                               outerType: .animatedRing(segmentsCount: _segmentsCount,
                                                                        rotationSpeed: _rotationSpeed,
                                                                        directionClockwise: _directionClockwise,
                                                                        isStacked: _isStacked,
                                                                        spaceAfter: 0,
                                                                        acceleration: 0),
                                               innerType: .brick(state: .random(),
                                                                 blinkInterval: 0,
                                                                 spaceAfter: 0,
                                                                 acceleration: acceleration),
                                               type: innerType)
            return stone
        default:
            assertionFailure("incorrect stone type for " + String(describing: InnerOuterRingObstacle.self))
            return nil
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
