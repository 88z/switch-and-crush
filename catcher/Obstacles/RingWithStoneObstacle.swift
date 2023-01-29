//
//  StonedRingObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 29.01.2023.
//

import Foundation
import SpriteKit

class RingWithStoneObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return false
        }
    }
    
    private let radius: CGFloat
    
    private var center: CGPoint {
        get {
            return CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
    init (mask: Mask, radius: CGFloat, colorScheme: ColorScheme, type: ObstacleType) {
        
        var isStacked = false
        var segmentsCount = 0
        var acceleration = 0
        var rotationSpeed: Speed = .none
        var directionClockwise = true
        var spaceAfter: CGFloat = 0
        switch type {
        case .ringWithStone(segmentsCount: let _segmentsCount, rotationSpeed: let _rotationSpeed, directionClockwise: let _directionClockwise, isStacked: let _isStacked, spaceAfter: let _spaceAfter, acceleration: let _acceleration):
            isStacked = _isStacked
            segmentsCount = Int(round(Double(_segmentsCount) / 2.0)) * 2
            rotationSpeed = _rotationSpeed
            acceleration = _acceleration
            spaceAfter = _spaceAfter
            directionClockwise = _directionClockwise
        default:
            assertionFailure("incorrect type for " + String(describing: RingWithStoneObstacle.self))
        }

        self.radius = radius
        super.init(colorScheme: colorScheme, blinkInterval: 0, spaceAfter: spaceAfter, acceleration: acceleration)
        initParts(mask: mask, segmentsCount: segmentsCount, rotationSpeed: rotationSpeed, directionClockwise: directionClockwise, isStacked: isStacked)
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(circleOfRadius: radius, center: center)
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
        addChild(RingObstacle(mask: mask, radius: radius, colorScheme: colorScheme, type: ringObstacldType))
        
        let stoneObstacleType = ObstacleType.stone(state: .random(), blinkInterval: 0, spaceAfter: 0, acceleration: acceleration)
        let stone = RectObstacle(mask: mask, width: STONE_OBSTACLE_HEIGHT, colorScheme: colorScheme, type: stoneObstacleType)
        stone.position = CGPoint(x: -STONE_OBSTACLE_HEIGHT/2, y: -STONE_OBSTACLE_HEIGHT/2)
        addChild(stone)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
