//
//  HeroShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 28.06.2022.
//

import Foundation
import SpriteKit

class HeroShatter {
    private let atomRadius: CGFloat
    private let hero: Hero
    private let rowCount: Int = 2
    private let frame:CGRect
    
    init (hero: Hero) {
        self.hero = hero
        self.frame = hero.path!.boundingBox
        self.atomRadius = frame.size.height/(2*CGFloat(rowCount))
    }
    
    func shatter(contactPoint: CGPoint) {
        guard let scene = hero.scene else {
            return
        }
        hero.removeFromParent()
        let colCount = rowCount
        var collisionAtoms:[SKShapeNode] = []
        var atoms:[SKShapeNode] = []
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atom = StateNode(circleOfRadius: atomRadius)
                atom.state = hero.state
                atom.lineWidth = 0
                atom.physicsBody = SKPhysicsBody(circleOfRadius: atomRadius, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                atom.physicsBody?.affectedByGravity = false
                atom.physicsBody?.categoryBitMask = 0b1000
                atom.physicsBody?.collisionBitMask = 0b1000
                atom.physicsBody?.restitution = 1
                scene.addChild(atom)
                if abs(contactPoint.x - atom.frame.midX) <= CGFloat(atomRadius*2) {
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
