//
//  HeroShatter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 28.06.2022.
//

import Foundation
import SpriteKit

class HeroShatterer {
    private let heroRadius: CGFloat
    private let hero: Hero
    private let rowCount: Int = 10
    private let frame:CGRect
    private let atomSize:CGFloat
    
    init (hero: Hero) {
        self.hero = hero
        self.frame = hero.frame
        self.atomSize = frame.size.height/(CGFloat(rowCount))
        self.heroRadius = frame.size.height/2
    }
    
    func shatter(contactPoint: CGPoint,  completion: @escaping()->Void) {
        guard let scene = hero.scene else {
            return
        }
        hero.removeFromParent()
        let colCount = rowCount
        var collisionAtoms:[SKShapeNode] = []
        var atoms:[SKShapeNode] = []
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let atom = StateNode(rect:CGRect(x: 0, y: 0, width: CGFloat(atomSize), height: CGFloat(atomSize)))
                atom.position = CGPoint(x: frame.origin.x + CGFloat(atomSize)*CGFloat(col), y: frame.origin.y + CGFloat(atomSize)*CGFloat(row))
                
                if (CGPointDistance(from: CGPoint(x: frame.midX, y: frame.midY), to: atom.position) > heroRadius) {
                    continue
                }
                atom.state = hero.state
                atom.lineWidth = 0
                atom.physicsBody = SKPhysicsBody(circleOfRadius: atomSize/2, center: CGPoint(x: atom.frame.midX, y: atom.frame.midY))
                atom.physicsBody?.affectedByGravity = false
                atom.physicsBody?.categoryBitMask = 0b1000
                atom.physicsBody?.collisionBitMask = 0b1000
                atom.physicsBody?.restitution = 1
                scene.addChild(atom)
                if abs(contactPoint.x - atom.frame.midX) <= CGFloat(atomSize*1.5) {
                    collisionAtoms.append(atom)
                }
                atoms.append(atom)
            }
        }
        var i:CGFloat = -1
        for atom in collisionAtoms {
            atom.physicsBody?.applyImpulse(CGVector(dx: i*0.02, dy: 0.01))
            i = i * -1
        }
        
        let fadeAction = SKAction.fadeOut(withDuration: 2)
        let group = DispatchGroup()
        for atom in atoms {
            group.enter()
            atom.run(fadeAction) {
                atom.removeFromParent()
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
}
