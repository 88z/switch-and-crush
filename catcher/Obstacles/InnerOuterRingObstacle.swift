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
    private let outerType: ObstacleType
    
    
    init (mask: Mask, outerRadius: CGFloat, innerRadius: CGFloat, colorScheme: ColorScheme, outerType: ObstacleType, innerType: ObstacleType, type: ObstacleType) {
        
        var acceleration = 0
        var spaceAfter: CGFloat = 0
        switch outerType {
        case .solidRing(segmentsCount: _,
                                rotationSpeed: _,
                                directionClockwise: _,
                                isStacked: _,
                                spaceAfter: let _spaceAfter,
                                acceleration: let _acceleration),
                .fragmentedRing(segmentsCount: _,
                                rotationSpeed: _,
                                directionClockwise: _,
                                isStacked: _, spaceAfter: let _spaceAfter,
                                acceleration: let _acceleration):
                 acceleration = _acceleration
                 spaceAfter = _spaceAfter
        default:
            assertionFailure("incorrect outer type for " + String(describing: InnerOuterRingObstacle.self))
        }

        self.outerType = outerType
        self.outerRadius = outerRadius
        self.innerRadius = innerRadius
        self.innerType = innerType
        super.init(colorScheme: colorScheme, blinkInterval: 0, spaceAfter: spaceAfter, acceleration: acceleration)
        self.type = type
        initParts(mask: mask)
        name = String(describing: Obstacle.self)
        
    }
    
    private func initParts(mask:Mask) {
        switch outerType {
        case .solidRing:
            addChild(RingObstacle(mask: mask, radius: outerRadius, colorScheme: colorScheme, type: outerType))
        case .fragmentedRing:
            addChild(FragmentedRingObstacle(mask: mask, radius: outerRadius, type: outerType, colorScheme: colorScheme))
        default:
            assertionFailure("incorrect stone type for " + String(describing: InnerOuterRingObstacle.self))
        }
        
        guard let stone = initInnerPart(mask: mask) else {
            return
        }
        addChild(stone.node)
    }
    
    private func initInnerPart(mask: Mask) -> Obstacle? {
        switch innerType {
        case .brick:
            let innerPart =  RectObstacle(mask: mask, width: STONE_OBSTACLE_HEIGHT, colorScheme: colorScheme, type: innerType)
            innerPart.node.position = CGPoint(x: -STONE_OBSTACLE_HEIGHT/2, y: -STONE_OBSTACLE_HEIGHT/2)
            return innerPart
        case .solidRing:
            let innerPart = RingObstacle(mask: mask, radius: innerRadius, colorScheme: colorScheme, type: innerType)
            return innerPart
        case .fragmentedRing:
            let innerPart = FragmentedRingObstacle(mask: mask, radius: FRAGMENTED_RING_RADIUS, type: innerType, colorScheme: colorScheme)
            return innerPart
        case .ringWithBrick(segmentsCount: let _segmentsCount, rotationSpeed: let _rotationSpeed, directionClockwise: let _directionClockwise, isStacked: let _isStacked, spaceAfter: _, acceleration: _):
            let stone = InnerOuterRingObstacle(mask: mask,
                                               outerRadius: innerRadius,
                                               innerRadius: 0,
                                               colorScheme: colorScheme,
                                               outerType: .solidRing(segmentsCount: _segmentsCount,
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
