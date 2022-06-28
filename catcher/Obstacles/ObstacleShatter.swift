//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class ObstacleShatter {
    private let atomSize: CFloat
    private let obstacle: Obstacle
    private let frame: CGRect
    private let rowCount:Int = 3
    init (obstacle: Obstacle) {
        self.obstacle = obstacle
        frame = obstacle.frame
        atomSize = CFloat(Float(obstacle.frame.size.height)/Float(rowCount))

        
    }
    func shatter(contactPoint: CGPoint) {
        guard let scene = obstacle.scene else {
            return
        }
        obstacle.removeFromParent()
        
        let colCount = Int(Float(obstacle.frame.size.width) / Float(atomSize))
        
        var collisionAtoms:[SKShapeNode] = []
        var atoms:[SKShapeNode] = []
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atom = StateNode(rect:CGRect(x: frame.origin.x + CGFloat(atomSize)*CGFloat(col), y: frame.origin.y + CGFloat(atomSize)*CGFloat(row), width: CGFloat(atomSize), height: CGFloat(atomSize)))
                atom.state = obstacle.state
                atom.lineWidth = 0
                atom.physicsBody = SKPhysicsBody(rectangleOf: atom.frame.size, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                atom.physicsBody?.affectedByGravity = false
                atom.physicsBody?.categoryBitMask = 0b1000
                atom.physicsBody?.collisionBitMask = 0b1000
                atom.physicsBody?.restitution = 1
                scene.addChild(atom)
                
                if abs(contactPoint.x - atom.frame.midX) <= CGFloat(atomSize) {
                    collisionAtoms.append(atom)
                }
                atoms.append(atom)
            }
        }
        var i = 1
        for atom in collisionAtoms {
            atom.physicsBody?.applyImpulse(CGVector(dx: 3*i   , dy: 1))
            i = i * -1
        }
        
        let fadeAction = SKAction.fadeOut(withDuration: 0.5)
        for atom in atoms {
            atom.run(fadeAction) {
                atom.removeFromParent()
            }
        }
    }
    
    
    
}
