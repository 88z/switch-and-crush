//
//  ObstacleContainer.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

class MultiStateObstacle: SKShapeNode, Obstacle {
    var colorScheme: ColorScheme
    var blinkInterval: TimeInterval
    
    func shatteringDummy() -> SKNode {
        let dummy = SKNode()
        for part in parts() {
            let partDummy = part.shatteringDummy()
            partDummy.position = part.node.position
            dummy.addChild(partDummy)
        }
        dummy.zRotation = self.zRotation
        return dummy
    }
    
    
    var isSolid: Bool {
        get {
            fatalError("should implement it in the subclass")
        }
    }
    
    func willBeShattered() {}
    
    func onAddedToScene() {}
    
    var type: ObstacleType! = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(colorScheme: ColorScheme, blinkInterval: TimeInterval){
        self.colorScheme = colorScheme
        self.blinkInterval = blinkInterval
        super.init()
    }
    
    
    var node: SKNode {
        return self
    }
    
    var velocity: CGFloat {
        get {
            return physicsBody?.velocity.dy ?? parts().first?.velocity ?? 0
        }
        
        set {
            physicsBody?.velocity.dy = newValue
            for  obstacle in parts() {
                obstacle.velocity = newValue
            }
        }
    }

    func state(at point: CGPoint) -> State? {
        guard let scene = scene else {
            assertionFailure("obstacle is not on scene")
            return nil
        }
        
        let lPoint = convert(point, from: scene)
        
        for obstacle in parts() {
            if obstacle.node.scene?.contains(lPoint) ?? false {
                return obstacle.state(at: point)
            }
        }
        return nil
    }
    
    func contactTest(at point: CGPoint, state: State) -> Bool {
        return self.state(at: point) == state
    }

    func parts() -> [Obstacle] {
        return self[String(describing: Obstacle.self)] as! [Obstacle]
    }
    
    func leafParts() -> [Obstacle] {
        return _leafParts(obstacle: self, collectedParts: [])
    }
    
    private func _leafParts(obstacle: Obstacle, collectedParts: [Obstacle]) -> [Obstacle] {
        var collectedParts = collectedParts
        if obstacle is MultiStateObstacle {
            for part in obstacle.parts() {
                collectedParts = _leafParts(obstacle: part, collectedParts: collectedParts)
            }
            return collectedParts
        } else {
            return collectedParts + [obstacle]
        }
    }
    
    func parent() -> Obstacle? {
        return parent as? Obstacle ?? nil
    }
    
}
