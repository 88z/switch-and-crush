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
    
    private var center: CGPoint {
        get {
            return CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
    private let innerType: ObstacleType
    
    init (mask: Mask, outerRadius: CGFloat, innerRadius: CGFloat, colorScheme: ColorScheme, outerType: ObstacleType, innerType: ObstacleType) {
        var isStacked = false
        var segmentsCount = 0
        var acceleration = 0
        var rotationSpeed: Speed = .none
        var directionClockwise = true
        var spaceAfter: CGFloat = 0
        switch outerType {
        case .ringWithBrick(segmentsCount: let _segmentsCount, rotationSpeed: let _rotationSpeed, directionClockwise: let _directionClockwise, isStacked: let _isStacked, spaceAfter: let _spaceAfter, acceleration: let _acceleration):
            isStacked = _isStacked
            segmentsCount = Int(round(Double(_segmentsCount) / 2.0)) * 2
            rotationSpeed = _rotationSpeed
            acceleration = _acceleration
            spaceAfter = _spaceAfter
            directionClockwise = _directionClockwise
        case .doubleRing(outerSegmentsCount: let _outerSegmentsCount,
                         innerSegmentsCount: _,
                         outerRotationSpeed: let _outerRotationSpeed,
                         innerRotationSpeed: _,
                         outerIsStacked: let _outerIsStacked,
                         innerIsStacked: _,
                         outerDirectionClockwise: let _outerDirectionClockwise,
                         innerDirectionClockwise: _,
                         spaceAfter: let _spaceAfter,
                         acceleration: let _acceleration),
                .doubleRingWithBrick(outerSegmentsCount: let _outerSegmentsCount,
                                 innerSegmentsCount: _,
                                 outerRotationSpeed: let _outerRotationSpeed,
                                 innerRotationSpeed: _,
                                 outerIsStacked: let _outerIsStacked,
                                 innerIsStacked: _,
                                 outerDirectionClockwise: let _outerDirectionClockwise,
                                 innerDirectionClockwise: _,
                                 spaceAfter: let _spaceAfter,
                                 acceleration: let _acceleration):
            isStacked = _outerIsStacked
            segmentsCount = Int(round(Double(_outerSegmentsCount) / 2.0)) * 2
            rotationSpeed = _outerRotationSpeed
            acceleration = _acceleration
            spaceAfter = _spaceAfter
            directionClockwise = _outerDirectionClockwise
        default:
            assertionFailure("incorrect type for " + String(describing: InnerOuterRingObstacle.self))
        }

        self.outerRadius = outerRadius
        self.innerRadius = innerRadius
        self.innerType = innerType
        super.init(colorScheme: colorScheme, blinkInterval: 0, spaceAfter: spaceAfter, acceleration: acceleration)
        initParts(mask: mask, segmentsCount: segmentsCount, rotationSpeed: rotationSpeed, directionClockwise: directionClockwise, isStacked: isStacked)
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
    
    private func initParts(mask:Mask, segmentsCount: Int, rotationSpeed: Speed, directionClockwise: Bool, isStacked: Bool) {
        let ringObstacldType = ObstacleType.animatedRing(segmentsCount: segmentsCount, rotationSpeed: rotationSpeed, directionClockwise: directionClockwise, isStacked: isStacked, spaceAfter: 0, acceleration: acceleration)
        addChild(RingObstacle(mask: mask, radius: outerRadius, colorScheme: colorScheme, type: ringObstacldType))
        
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
        case .ringWithBrick:
            let stone = InnerOuterRingObstacle(mask: mask, outerRadius: innerRadius, innerRadius: 0, colorScheme: colorScheme, outerType: innerType, innerType: .brick(state: .random(), blinkInterval: 0, spaceAfter: 0, acceleration: 0))
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
