//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class ObstacleShatter {
    private var atomSize: CFloat {
        get {
            return CFloat(Float(obstacle.node.frame.size.height)/Float(rowCount))
        }
    }
    private let obstacle: Obstacle
    private var frame: CGRect {
        get {
            guard let scene = obstacle.node.scene else {
                fatalError("obstacle has no scene")
            }
            guard let parent = obstacle.node.parent  else {
                return obstacle.node.frame
            }
            return scene.convertRect(obstacle.node.frame, from: parent)
        }
    }
    private var rowCount:Int {
        get {
            return Int(obstacle.node.frame.size.height/7)
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
       return Int(Float(obstacle.node.frame.size.width) / Float(atomSize))
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
            
            let frame = scene.convertRect(obstacle.node.frame, from: obstacle.node.parent ?? scene)
            let colCount = colCount(for: obstacle)
            for row in 0..<rowCount {
                for col in 0..<colCount {
                    let atom = StateNode(rect:CGRect(x: frame.origin.x + CGFloat(atomSize)*CGFloat(col), y: frame.origin.y + CGFloat(atomSize)*CGFloat(row), width: CGFloat(atomSize), height: CGFloat(atomSize)))
                    atom.state = obstacle.state(at: .zero)
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
        let rootParent = ObstacleShatter.rootParent(of: obstacle)
        let atoms = atoms(from: rootParent)
        for atom in atoms {
            scene.addChild(atom)
            let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
            if abs(contactPoint.x - atomMid.x) <= CGFloat(atomSize) {
                collisionAtoms.append(atom)
            }
        }
        var i = 1
        let xMultiplier: CGFloat
        let yMultiplier: CGFloat
        
        switch obstacle.type {
        case .square:
            xMultiplier = 0.35
            yMultiplier = 0.35
        default:
            xMultiplier = 3
            yMultiplier = 1
        }
        
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
