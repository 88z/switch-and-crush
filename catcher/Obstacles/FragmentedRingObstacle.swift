//
//  FragmentedRingObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 28.07.2022.
//

import Foundation
import SpriteKit

class FragmentedRingObstacle: MultiStateObstacle {
    
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
    
    override var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
                
            }
            get {
                physicsBody?.velocity.dy ?? 0
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
        physicsBody?.setZeroMask()
        
        initParts(mask: mask, states:states)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initParts(mask: Mask, states: [State]){
        guard states.count > 0 else {
            return
        }
        let partAngle = 2*CGFloat.pi/CGFloat(states.count)
        var startAngle:CGFloat = 0
        let spaceAngle:CGFloat = 0.3

        for state in states {
            let endAngle = startAngle + partAngle - spaceAngle
        
            let node = ArcObstacle(mask: mask, state: state, center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, type: .arcObstacle)
            
            addChild(node)
            startAngle = endAngle + spaceAngle
        }
    }
    
    override func state(at point: CGPoint) -> State? {
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
    
    override func onAddedToScene() {
        for obstacle in parts() {
            let position = scene!.convert(.zero, from: self)
            scene!.physicsWorld.add(SKPhysicsJointFixed.joint(withBodyA: physicsBody!, bodyB: obstacle.node.physicsBody!, anchor: position))
        }
    }
}
