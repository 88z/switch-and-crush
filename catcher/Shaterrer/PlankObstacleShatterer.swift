//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class PlankObstacleShatterer: Shatterer {
    
    private let obstacle: Obstacle

    init (obstacle: Obstacle) {
        self.obstacle = obstacle
    }
    
    
    func shatter(contactPoint: CGPoint) {
        guard let scene = obstacle.node.scene else {
            return
        }
        var collisionAtoms:[SKNode] = []
        let firstSolidParent = obstacle.firstSolidParent
        firstSolidParent.willBeShattered()
        
        let dummy = firstSolidParent.shatteringDummy()
        dummy.position = scene.convert(firstSolidParent.node.position, from: firstSolidParent.node.parent ?? scene)
        scene.addChild(dummy)
        let atoms = dummy.descendants(with: ATOM_NODE_NAME)
        guard let atomSize = atoms.first?.frame.size.width else {
            return
        }
        for atom in atoms {
            let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
            if abs(contactPoint.x - atomMid.x) <= CGFloat(atomSize) {
                collisionAtoms.append(atom)
            }
        }
       
        let xMultiplier: CGFloat
        let yMultiplier: CGFloat
        let angularMultiplier: CGFloat
        switch obstacle.type {
        case .brick:
            angularMultiplier = 0.0002
            xMultiplier = 1.0
            yMultiplier = 1.0
        default:
            angularMultiplier = 0.002
            xMultiplier = 5
            yMultiplier = 1
        }
        

        var i:CGFloat = 1
        for atom in collisionAtoms {
            atom.physicsBody?.applyAngularImpulse(angularMultiplier*i)
            atom.physicsBody?.applyImpulse(CGVector(dx: xMultiplier*CGFloat(i), dy: yMultiplier))
            i = i * -1
        }

        dummy.run(SKAction.fadeOut(withDuration: 0.5)) {
            dummy.removeFromParent()
        }
        firstSolidParent.remove()
    }
}
