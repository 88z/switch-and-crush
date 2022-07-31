//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class PlankObstacleShatterer {
    
    private var atomSize: CFloat {
        get {
            return CFloat(Float(obstacle.node.calculateAccumulatedFrame().size.height)/Float(rowCount))
        }
    }
    
    private let obstacle: Obstacle
    
    private var rowCount:Int {
        get {
            return Int(obstacle.node.calculateAccumulatedFrame().size.height/7)
        }
    }

    init (obstacle: Obstacle) {
        self.obstacle = obstacle
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
                    let state = obstacle.state(at: atomOrigin, isContactTest: false)

                    guard let state = state else {
                        continue
                    }
                    
                    let atom = StateNode(rect:CGRect(origin: atomOrigin, size: CGSize(width: CGFloat(atomSize), height: CGFloat(atomSize))))
                    atom.state = state
                    
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
        let firstSolidParent = obstacle.firstSolidParent
        firstSolidParent.willBeShattered()
        let atoms = atoms(from: firstSolidParent)
        for atom in atoms {
            scene.addChild(atom)
            let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
            if abs(contactPoint.x - atomMid.x) <= CGFloat(atomSize) {
                collisionAtoms.append(atom)
            }
        }
       
        let xMultiplier: CGFloat = 3
        let yMultiplier: CGFloat = 1

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
        firstSolidParent.node.removeFromParent()
    }
}
