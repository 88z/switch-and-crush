//
//  PlankStackObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.07.2022.
//

import Foundation
import SpriteKit

class StackObstacle: MultiStateObstacle {
    var rotationContainer: SKNode?
    
    override var velocity: CGFloat {
        get {
            if type == .rotatingSquareStack {
                return rotationContainer?.physicsBody?.velocity.dy ?? 0
            } else {
                return super.velocity
            }
            
        }
        
        set {
            if type == .rotatingSquareStack {
                rotationContainer?.physicsBody?.velocity.dy = newValue
            } else {
                super.velocity = newValue
            }
            
        }
    }
    
    init(mask:Mask, width: CGFloat, states: [State], type: ObstacleType) {
        super.init()
        name = String(describing: Obstacle.self)
        self.type = type
        
        let partType: ObstacleType
        switch type {
        case .plankStack:
            partType = .thinPlank
        case .squareStack, .rotatingSquareStack:
            partType = .squareStackPart
        default:
            partType = .thinPlank
        }
        
        if type == .rotatingSquareStack {
            rotationContainer = SKNode()
            rotationContainer?.position = CGPoint(x: width/2 , y: width/2)
            addChild(rotationContainer!)
            rotationContainer?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: width), center: CGPoint(x: 0 , y: 0))
            rotationContainer?.physicsBody?.affectedByGravity = false
            rotationContainer?.physicsBody?.restitution = 0
            rotationContainer?.physicsBody?.friction = 0
            rotationContainer?.physicsBody?.linearDamping = 0
            rotationContainer?.physicsBody?.setZeroMask()
            rotationContainer?.physicsBody?.angularDamping = 0
            rotationContainer?.physicsBody?.angularVelocity = 2
            rotationContainer?.physicsBody?.density = 0
        }
        
        var nextY:CGFloat = 0
        for state in states {
            
            let obstacle = RectObstacle(mask: mask, width: width, type: partType)
            obstacle.state = state
            (rotationContainer ?? self).addChild(obstacle)
            obstacle.position = type == .rotatingSquareStack ? CGPoint(x:0-width/2, y:nextY-width/2) : CGPoint(x: 0, y: nextY)
            nextY = nextY + obstacle.frame.size.height - 2

        }
        
        
    }
    
    override func onAddedToScene() {
        let obstacles = parts()
        guard let rotationContainer = rotationContainer,
              let scene = scene,
              obstacles.count>=2 else{
            return
        }
        
        for obstacle in parts() {
            let position = scene.convert(.zero, from: rotationContainer)
            scene.physicsWorld.add(SKPhysicsJointFixed.joint(withBodyA: rotationContainer.physicsBody!, bodyB: obstacle.node.physicsBody!, anchor: position))
        }
        
    }
    
    override func parts() -> [Obstacle] {
        return (rotationContainer ?? self)[String(describing: Obstacle.self)] as! [Obstacle]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willBeShattered() {
        rotationContainer?.zRotation = 0
    }
}
