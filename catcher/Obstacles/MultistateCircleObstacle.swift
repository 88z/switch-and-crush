//
//  MultistateCircleObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 23.07.2022.
//

import Foundation
import SpriteKit

class MultistateCircleObstacle: MultiStateObstacle {
    override var velocity: CGFloat {
            set {
                physicsBody?.velocity.dy = newValue
                
            }
            get {
                physicsBody?.velocity.dy ?? 0
            }
    }
    
    override func state(at point: CGPoint) -> State {
        guard let scene = scene else {
            fatalError("obstacle is not on scene")
        }
        let pnt = scene.convert(point, to: self)
        
        let state = (nodes(at: pnt).first as! StateNode).state
        return state
    }

    
    private let radius: CGFloat
    
    private var center: CGPoint {
        get {
            return CGPoint(x: frame.midX, y: frame.midY)
        }
    }
    
    init (mask: Mask, radius: CGFloat, states:[State], type: ObstacleType, rotationVelocity: CGFloat) {
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
        physicsBody?.angularVelocity = rotationVelocity
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
            let path = UIBezierPath()
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            path.close()
            
            let node = StateNode(path: path.cgPath)
            node.state = state
            addChild(node)
            startAngle = endAngle
            
        }
        
    }
    
}
