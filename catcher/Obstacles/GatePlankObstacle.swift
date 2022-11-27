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
        self.isStacked = false
        super.init(colorScheme: colorScheme, blinkInterval: 0, acceleration: 0)
        
        let state = State.first
        let duration: TimeInterval = 2
        
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
        
        let leftCloseAction = SKAction.moveBy(x: width/2-1, y: 0, duration: duration)
        let diveAction = SKAction.run {
            part1Left.zPosition = 0
            part1Right.zPosition = 0
        }
        let surfaceAction = SKAction.run {
            part1Left.zPosition = 2
            part1Right.zPosition = 2
        }
        let waitAction = SKAction.wait(forDuration: duration)
        let leftOpenAction = SKAction.moveBy(x: -width/2+1, y: 0, duration: 0)
        
        let rightCloseAction = SKAction.moveBy(x: -width/2, y: 0, duration: duration)
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
    
    private func initPart(mask:Mask, state: State, width: CGFloat) -> StateNode{
            return StateNode(rect: CGRect(x: 0, y: 0, width: width, height: height),
                             state: state,
                             colorScheme: colorScheme,
                             blinkInterval: blinkInterval)
            
    }
    
    private func states(at point: CGPoint, isContactTest: Bool) -> [State] {
        var states:[State] = []
        let circle = UIBezierPath(arcCenter: point, radius: 5, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true).cgPath
        
        var childrenAtPoint:[StateNode] = []
        for child in children {
            guard let child = child as? StateNode,
                  let childPath = child.path
            else {
                continue
            }
            let path = CGPathFrom(cgPath: childPath, movedTo: child.position)
            
            if isContactTest ? path.intersects(circle) : path.contains(point) {
                childrenAtPoint.append(child)
            }
        }
        
        let maxZPozition = (childrenAtPoint.max { child1, child2 in
            child1.zPosition < child2.zPosition
        })?.zPosition ?? 0
        
        for child in childrenAtPoint {
            if child.zPosition == maxZPozition {
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
        let frame = calculateAccumulatedFrame()
        let rowCount = Int(height/atomSize)
        let colCount = Int(width/atomSize)
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atomOrigin = CGPoint(x: CGFloat(atomSize)*CGFloat(col), y: CGFloat(atomSize)*CGFloat(row))
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
