//
//  ObstacleShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

class RingObstacleShatterer: Shatterer {
    
    
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
    
    
    func shatter(contactPoint: CGPoint) {
        guard let scene = obstacle.node.scene else {
            return
        }
        var collisionAtoms:[SKShapeNode] = []
        let obstacleToShatter = obstacle.firstSolidParent
        obstacleToShatter.willBeShattered()
        let dummy = obstacleToShatter.dummyForShattering()
        dummy.position = scene.convert(obstacleToShatter.node.position, from: obstacleToShatter.node.parent ?? scene)
        scene.addChild(dummy)
        
        let atoms = dummy.children as! [SKShapeNode]
        guard atoms.count > 0 else {
            return
        }
        let atomSize = max(atoms.first!.frame.size.width, atoms.first!.frame.size.height)
        
        for atom in dummy.children as! [SKShapeNode] {
            let atomMid = scene.convert(CGPoint(x: atom.frame.midX, y: atom.frame.midY), from: atom.parent ?? scene)
            if abs(contactPoint.x - atomMid.x) <= CGFloat(atomSize) {
                collisionAtoms.append(atom)
            }
            
        }

        var i:CGFloat = 1
        for atom in collisionAtoms {
            atom.physicsBody?.applyAngularImpulse(0.002*i)
            i = i * -1
        }

        dummy.run(SKAction.fadeOut(withDuration: 0.5)) {
            dummy.removeFromParent()
        }
        obstacleToShatter.node.removeFromParent()
    }
    
    
}
