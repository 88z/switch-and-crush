//
//  MultistateCircleObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 23.07.2022.
//

import Foundation
import SpriteKit

class MultistateRingObstacle: MultiStateObstacle {
    override var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
                
            }
            get {
                physicsBody?.velocity.dy ?? 0
            }
    }
    
    override var isSolid: Bool {
        get {
            return true
        }
    }

    private let radius: CGFloat
    
    private var center: CGPoint {
        get {
            return CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
    init (mask: Mask, radius: CGFloat, states:[State], type: ObstacleType, rotationSpeed: Speed) {
        self.radius = radius
        super.init()
        self.type = type
        name = String(describing: Obstacle.self)
        physicsBody = SKPhysicsBody(circleOfRadius: radius, center: center)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        switch rotationSpeed {
        case .none:
            physicsBody?.angularVelocity = 0
        case .slow:
            physicsBody?.angularVelocity = 0.5
        case .medium:
            physicsBody?.angularVelocity = 1
        case .fast:
            physicsBody?.angularVelocity = 2
        case .crazy:
            physicsBody?.angularVelocity = 3
        }
        physicsBody?.density = 0.025
        physicsBody?.set(mask: mask)
        initParts(with: states)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initParts(with states: [State]){
        guard states.count > 0 else {
            return
        }
        let partAngle = 2*CGFloat.pi/CGFloat(states.count)
        var startAngle:CGFloat = 0

        for state in states {
            let endAngle = startAngle + partAngle
            let node = StateNode(arcWithCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, width: 7)
            node.state = state
            addChild(node)
            startAngle = endAngle
        }
    }
    
    override func state(at point: CGPoint, isContactTest: Bool) -> State? {
        guard let scene = scene else {
            fatalError("obstacle is not on scene")
        }
        var state: State? = nil
        let pnt = scene.convert(point, to: self)
        
        for child in children {
            guard let child = child as? StateNode,
                  let path = child.path else {
                continue
            }
            if path.contains(pnt) {
                state = child.state
                break
            }
        }
        return state
    }
}
