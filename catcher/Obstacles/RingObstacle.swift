//
//  MultistateCircleObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 23.07.2022.
//

import Foundation
import SpriteKit
import CGPathIntersection

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
    
    let width: CGFloat = ARC_OBSTACLE_THICKNESS
    let isStacked: Bool
    
    init (mask: Mask, radius: CGFloat, colorScheme: ColorScheme, type: ObstacleType) {
        self.radius = radius
        
        var isStacked = false
        var partsCount = 0
        var acceleration = 0
        var rotationSpeed: Speed = .none
        var directionClockwise = true
        var spaceAfter: CGFloat = 0
        switch type {
        case .animatedRing(segmentsCount: let _segmentsCount,
                           rotationSpeed: let _rotationSpeed,
                           directionClockwise: let _directionClockwise,
                           isStacked: let _isStacked,
                           spaceAfter: let _spaceAfter,
                           acceleration: let _acceleration):
            isStacked = _isStacked
            partsCount = Int(round(Double(_segmentsCount) / 2.0)) * 2
            rotationSpeed = _rotationSpeed
            acceleration = _acceleration
            spaceAfter = _spaceAfter
            directionClockwise = _directionClockwise
        default:
            assertionFailure("incorrect type for " + String(describing: RingObstacle.self))
        }
        self.isStacked = isStacked
        super.init(colorScheme: colorScheme, blinkInterval: 0, spaceAfter: spaceAfter, acceleration: acceleration)
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
            physicsBody?.angularVelocity = 4
        }
        if !directionClockwise {
            physicsBody?.angularVelocity = -(physicsBody?.angularVelocity ?? 0)
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
        for _ in 0..<partsCount {
            let endAngle = startAngle + partAngle
            let node1 = StateNode(arcWithCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, width: width, state: state, colorScheme: colorScheme, blinkInterval: blinkInterval)
            addChild(node1)
            state = State.nextState(for: state)
            if isStacked {
                let node2 = StateNode(arcWithCenter: center, radius: radius-width, startAngle: startAngle, endAngle: endAngle, width: width, state: state, colorScheme: colorScheme, blinkInterval: blinkInterval)
                addChild(node2)
            }
            
            startAngle = endAngle
        }
    }
    
    private func state(at angle:CGFloat)->State? {
        let radius = radius-width/2
        return state(at: CGPoint(x: radius*cos(angle), y: radius*sin(angle)))
    }
    
    override func state(at point: CGPoint) -> State? {
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
    
    func states(at point: CGPoint) -> [State] {
        guard let parent = parent else {
            return []
        }
        var states: [State] = []
        for child in children {
            guard let child = child as? StateNode,
                  let path = child.path else {
                continue
            }
            
            let deltaAngle = 0.1
            let xDelta = radius*sin(deltaAngle)
            let yDelta = radius*(1-cos(deltaAngle))
            
            let pointInParentCoordinates = convert(point, to: parent)
            
            let leftBottomPointInParentCoordinates = CGPoint(x: pointInParentCoordinates.x-xDelta+0, y: pointInParentCoordinates.y-0-yDelta)
            let rightBottomPointInParentCoordinates = CGPoint(x: pointInParentCoordinates.x+xDelta-0, y: pointInParentCoordinates.y-0-yDelta)
            let leftBottomPoint = parent.convert(leftBottomPointInParentCoordinates, to: self)
            let rightBottomPoint = parent.convert(rightBottomPointInParentCoordinates, to: self)
            if path.contains(point)
                || path.contains(leftBottomPoint)
                || path.contains(rightBottomPoint) {
                states.append(child.state)
            }
            
            

        }
        if states.count == 0 {
            return [.first, .second]
        }

        return states
    }
    
    override func contactTest(at point: CGPoint, state: State) -> Bool {
        return self.states(at: point).contains(state)
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
            let atom = StateNode(arcWithCenter: .zero,
                                 radius: radius,
                                 startAngle: startAngle,
                                 endAngle: endAngle,
                                 width: width, state: state, colorScheme: colorScheme, blinkInterval: 0)
            atom.name = ATOM_NODE_NAME
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
