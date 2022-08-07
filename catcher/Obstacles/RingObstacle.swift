//
//  MultistateCircleObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 23.07.2022.
//

import Foundation
import SpriteKit

class RingObstacle: MultiStateObstacle {
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
    
    let width: CGFloat = OBSTACLE_ARK_THICKNESS
    
    init (mask: Mask, radius: CGFloat, partsCount: Int, type: ObstacleType, rotationSpeed: Speed) {
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
        initParts(count: partsCount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initParts(count partsCount: Int){
        guard partsCount > 0 else {
            return
        }
        let partAngle = 2*CGFloat.pi/CGFloat(partsCount)
        var startAngle:CGFloat = 0

        var state = State.random()
        for i in 0..<partsCount {
            let endAngle = startAngle + partAngle
            let node = StateNode(arcWithCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, width: width)
            node.state = state
            state = State.nextState(for: state)
            addChild(node)
            startAngle = endAngle
        }
    }
    
    private func state(at angle:CGFloat)->State? {
        let radius = radius-width/2
        return state(at: CGPoint(x: radius*cos(angle), y: radius*sin(angle)), isContactTest: false)
    }
    
    override func state(at point: CGPoint, isContactTest: Bool) -> State? {
        var state: State? = nil
        
        for child in children {
            guard let child = child as? StateNode,
                  let path = child.path else {
                continue
            }
            if path.contains(point) {
                state = child.state
                break
            }
        }
        return state
    }

    override func shatteringDummy() -> SKNode {
        let dummy = SKNode()
        let atomsCount = 32
        var startAngle:CGFloat = 0
        let atomAngle = 2*CGFloat.pi/CGFloat(atomsCount)
        
        for _ in 0..<atomsCount {
            let endAngle = startAngle + atomAngle
            guard let state = state(at: startAngle+(endAngle-startAngle)/2) else {
                continue
            }
            let atom = StateNode(arcWithCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, width: width)
            atom.state = state
            atom.physicsBody = SKPhysicsBody(polygonFrom: atom.path!)
            atom.physicsBody?.affectedByGravity = false
            atom.physicsBody?.categoryBitMask = 0b1000
            atom.physicsBody?.collisionBitMask = 0b1000
            atom.physicsBody?.restitution = 1
            dummy.addChild(atom)
            startAngle = endAngle
        }
        dummy.zRotation = zRotation
        return dummy
    }
    
}
