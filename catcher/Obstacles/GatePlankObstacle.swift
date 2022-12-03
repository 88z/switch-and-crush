//
//  GatePlankObstacle.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 20.11.2022.
//

import Foundation
import SpriteKit

class GatePlankObstacle: MultiStateObstacle {
    override var isSolid: Bool {
        get {
            return true
        }
    }
    
    private let width = CGFloat(UIScreen.main.bounds.size.width)
    private let height = PLANK_OBSTACLE_HEIGHT
    
    let isStacked:Bool
    init(mask: Mask, colorScheme: ColorScheme, type: ObstacleType) {
        var isStacked = false
        var blinkInterval: TimeInterval = 0
        var swingSpeed: Speed = .none
        var spaceAfter: CGFloat = 0
        var acceleration = 0
        switch type {
        case .gatePlank(swingSpeed: let _swingSpeed,
                        isStacked: let _isStacked,
                        blinkInterval: let _blinkInterval,
                        spaceAfter: let _spaceAfter,
                        acceleration: let _acceleration):
            blinkInterval = _blinkInterval
            isStacked = _isStacked
            swingSpeed = _swingSpeed
            spaceAfter = _spaceAfter
            acceleration = _acceleration
        default:
            assertionFailure("incorrect type for " + String(describing: PendulumPlankObstacle.self))
        }
        self.isStacked = isStacked
        super.init(colorScheme: colorScheme, blinkInterval: blinkInterval, spaceAfter: spaceAfter, acceleration: acceleration)
        let state = State.random()
        
        var swingDuration: TimeInterval
        switch swingSpeed {
        case .none:
            swingDuration = CGFloat.infinity
        case .slow:
            swingDuration = 4
        case .medium:
            swingDuration = 2
        case .fast:
            swingDuration = 1
        case .crazy:
            swingDuration = 0.5
        }
        
        
        let part1Left = initPart(mask: mask, state: state, width: width/2)
        part1Left.position = CGPoint(x: -width/2, y: 0)
        part1Left.zPosition = 2
        let part1Right = initPart(mask: mask, state: state, width: width/2)
        part1Right.position = CGPoint(x: width, y: 0)
        part1Right.zPosition = 2
        addChild(part1Left)
        addChild(part1Right)
        
        let part2Left = initPart(mask: mask, state: State.nextState(for: state), width: width/2)
        part2Left.position = CGPoint(x: 0, y: 0)
        part2Left.zPosition = 1
        let part2Right = initPart(mask: mask, state: State.nextState(for: state), width: width/2)
        part2Right.position = CGPoint(x: width/2, y: 0)
        part2Right.zPosition = 1
        addChild(part2Left)
        addChild(part2Right)
        

        name = String(describing: Obstacle.self)
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: width/2, y: height/2))
        physicsBody?.set(mask: mask)
        physicsBody?.affectedByGravity = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.linearDamping = 0
        
        let leftCloseAction = SKAction.moveBy(x: width/2-1, y: 0, duration: swingDuration)
        let diveAction = SKAction.run {
            part1Left.zPosition = 0
            part1Right.zPosition = 0
        }
        let surfaceAction = SKAction.run {
            part1Left.zPosition = 2
            part1Right.zPosition = 2
        }
        let waitAction = SKAction.wait(forDuration: swingDuration)
        let leftOpenAction = SKAction.moveBy(x: -width/2+1, y: 0, duration: 0)
        
        let rightCloseAction = SKAction.moveBy(x: -width/2, y: 0, duration: swingDuration)
        let rightOpenAction = SKAction.moveBy(x: width/2, y: 0, duration: 0)
        
        let part1LeftAction = SKAction.repeatForever(SKAction.sequence([surfaceAction, leftCloseAction, diveAction, waitAction, leftOpenAction]))
        part1Left.run(part1LeftAction)
        let part1RightAction = SKAction.repeatForever(SKAction.sequence([rightCloseAction, waitAction, rightOpenAction]))
        part1Right.run(part1RightAction)

        let part2LeftAction = SKAction.repeatForever(SKAction.sequence([waitAction, leftOpenAction, leftCloseAction]))
        part2Left.run(part2LeftAction)
        let part2RightAction = SKAction.repeatForever(SKAction.sequence([waitAction, rightOpenAction, rightCloseAction]))
        part2Right.run(part2RightAction)
        
        
    }
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> SKNode{
        let node: SKNode
        if isStacked {
            node = SKNode()
            let height = height/2
            let subPart1 = StateNode(rect: CGRect(x: 0, y: 0, width: width, height: height),
                               state: state,
                               colorScheme: colorScheme,
                               blinkInterval: blinkInterval)
            subPart1.name = String(describing: StateNode.self)
            node.addChild(subPart1)
            let subPart2 = StateNode(rect: CGRect(x: 0, y: height+1, width: width, height: height),
                               state: State.nextState(for: state),
                               colorScheme: colorScheme,
                               blinkInterval: blinkInterval)
            subPart2.name = String(describing: StateNode.self)
            node.addChild(subPart2)
            return node
        } else {
            node = StateNode(rect: CGRect(x: 0, y: 0, width: width, height: height),
                             state: state,
                             colorScheme: colorScheme,
                             blinkInterval: blinkInterval)
            node.name = String(describing: StateNode.self)
        }
        return node
    }
    
    private func states(at point: CGPoint, isContactTest: Bool) -> [State] {
        var states:[State] = []
        let circle = UIBezierPath(arcCenter: point, radius:1    , startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true).cgPath
        
        var childrenAtPoint:[StateNode] = []
        let children = descendants(with: String(describing: StateNode.self))
        for child in children {
            guard let child = child as? StateNode,
                  let childPath = child.path
            else {
                continue
            }
            var position = child.position
            if isStacked {
                position = child.parent?.convert(child.position, to: self) ?? .zero
            }
            let path = CGPathFrom(cgPath: childPath, movedTo: position)
            
            if isContactTest ? path.intersects(circle) : path.contains(point) {
                childrenAtPoint.append(child)
            }
        }
        
        let maxZPozition = (childrenAtPoint.max { child1, child2 in
            let zp1 = child1.absoluteZPosition()
            let zp2 = child2.absoluteZPosition()
            return zp1 < zp2
        })?.absoluteZPosition() ?? 0
        
        for child in childrenAtPoint {
            if child.absoluteZPosition() == maxZPozition {
                states.append(child.state)
            }
        }
        return states
    }
    
    override func contactTest(at point: CGPoint, state: State) -> Bool {
        return states(at: point, isContactTest: true).contains(state)
    }
    
    override func state(at point: CGPoint) -> State? {
        return states(at: point, isContactTest: false).first
    }
    
    override func shatteringDummy() -> SKNode {
        let dummy = SKNode()
        let atomSize = PLANK_ATOM_SIZE
        let rowCount = Int(height/atomSize)
        let colCount = Int(width/atomSize)
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atomOrigin = CGPoint(x: CGFloat(atomSize)*CGFloat(col), y: CGFloat(atomSize)*CGFloat(row)+1)
                guard let state = state(at: atomOrigin) else {
                    continue
                }
                let atom = StateNode(rect:CGRect(origin: atomOrigin, size: CGSize(width: CGFloat(atomSize), height: CGFloat(atomSize))), state: state, colorScheme: colorScheme, blinkInterval: 0)
                atom.name = ATOM_NODE_NAME
                atom.glowWidth = 2
                atom.physicsBody = SKPhysicsBody(rectangleOf: atom.frame.size, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                atom.physicsBody?.affectedByGravity = false
                atom.physicsBody?.categoryBitMask = 0b1000
                atom.physicsBody?.collisionBitMask = 0b1000
                atom.physicsBody?.restitution = 1
                dummy.addChild(atom)
            }
        }
        return dummy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
