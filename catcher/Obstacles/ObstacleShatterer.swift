//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class ObstacleShatterer {
    
    private var atomSize: CFloat {
        get {
            return CFloat(Float(obstacle.node.calculateAccumulatedFrame().size.height)/Float(rowCount))
        }
    }
    
    private let obstacle: Obstacle
    
    private var frame: CGRect {
        get {
            guard let scene = obstacle.node.scene else {
                fatalError("obstacle has no scene")
            }
            guard let parent = obstacle.node.parent  else {
                return obstacle.node.calculateAccumulatedFrame()
            }
            return scene.convertRect(obstacle.node.calculateAccumulatedFrame(), from: parent)
        }
    }
    
    private var rowCount:Int {
        get {
            return Int(obstacle.node.calculateAccumulatedFrame().size.height/7)
        }
    }

    init (obstacle: Obstacle) {
        self.obstacle = obstacle
    }
    
    
    private class func rootParent(of obstacle:Obstacle)->Obstacle {
        var parent = obstacle
        while parent.parent() != nil {
            parent = parent.parent()!
        }
        return parent
    }
    
    private func colCount(for obstacle:Obstacle) -> Int {
       return Int(Float(obstacle.node.calculateAccumulatedFrame().size.width) / Float(atomSize))
    }
    
    func atoms(from obstacle:Obstacle) -> [SKShapeNode]{
        var atoms:[SKShapeNode] = []
        let parts = obstacle.parts()
        
        if parts.count > 0 {
            for part in parts {
                atoms.append(contentsOf: self.atoms(from:part))
            }
            return atoms
        } else {
            guard let scene = obstacle.node.scene else {
                return []
            }
            let frame = scene.convertRect(obstacle.node.calculateAccumulatedFrame(), from: obstacle.node.parent!)  
            let colCount = colCount(for: obstacle)
            for row in 0..<rowCount {
                for col in 0..<colCount {

                    let atomOrigin = CGPoint(x: frame.origin.x + CGFloat(atomSize)*CGFloat(col), y: frame.origin.y + CGFloat(atomSize)*CGFloat(row))
                    let state = obstacle.state(at: atomOrigin)

                    guard let state = state else {
                        continue
                    }
                    
                    let atom = StateNode(rect:CGRect(origin: atomOrigin, size: CGSize(width: CGFloat(atomSize), height: CGFloat(atomSize))))
                    atom.state = state
                    
                    if (CGPointDistance(from: CGPoint(x: frame.midX, y: frame.midY), to: atomOrigin) > frame.size.width/2) {
                        continue
                    }
                    
                    atom.lineWidth = 0
                    atom.physicsBody = SKPhysicsBody(rectangleOf: atom.frame.size, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                    atom.physicsBody?.affectedByGravity = false
                    atom.physicsBody?.categoryBitMask = 0b1000
                    atom.physicsBody?.collisionBitMask = 0b1000
                    atom.physicsBody?.restitution = 1
                    atoms.append(atom)
                }
            }
            return atoms
        }
    }
    
    func shatter(contactPoint: CGPoint) {
        guard let scene = obstacle.node.scene else {
            return
        }
        var collisionAtoms:[SKShapeNode] = []
        let rootParent = ObstacleShatterer.rootParent(of: obstacle)
        rootParent.willBeShattered()
        let atoms = atoms(from: rootParent)
        for atom in atoms {
            scene.addChild(atom)
            let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
            if abs(contactPoint.x - atomMid.x) <= CGFloat(atomSize) {
                collisionAtoms.append(atom)
            }
        }
       
        let xMultiplier: CGFloat
        let yMultiplier: CGFloat
        
        switch obstacle.type {
        case .fourSegmentAnimatedRing:
            xMultiplier = 0.5
            yMultiplier = 0.5
        default:
            xMultiplier = 3
            yMultiplier = 1
        }
        
        if obstacle.type == .fourSegmentAnimatedRing {
            let obstacleFrame = obstacle.node.calculateAccumulatedFrame()
            let obstacleMid = scene.convert(CGPoint(x: obstacleFrame.midX, y: obstacleFrame.midY), from: obstacle.node.parent ?? scene)
            for atom in atoms {
                let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
                let vector = CGVector(CGVector(dx: obstacleFrame.width/2 * (atomMid.x>obstacleMid.x ? 0.5 :-0.5), dy: abs(atomMid.y - obstacleMid.y)), changeLenTo: 0.25)
                atom.physicsBody?.applyImpulse(vector)
            }
        }

        var i = 1
        for atom in collisionAtoms {
            atom.physicsBody?.applyImpulse(CGVector(dx: xMultiplier*CGFloat(i), dy: yMultiplier))
            i = i * -1
        }

        
        
        let fadeAction = SKAction.fadeOut(withDuration: 0.5)
        for atom in atoms {
            atom.run(fadeAction) {
                atom.removeFromParent()
            }
        }
        rootParent.node.removeFromParent()
    }
    
    
}
