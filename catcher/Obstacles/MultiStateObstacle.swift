//
//  ObstacleContainer.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

class MultiStateObstacle: SKShapeNode, Obstacle {
    func willBeShattered() {}
    
    func onAddedToScene() {}
    
    var type: ObstacleType! = nil
    
    
    init(mask: Mask, width: CGFloat) {
        fatalError("tou should implement it in the subclass")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(){
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
            for var obstacle in parts() {
                obstacle.velocity = newValue
            }
        }
    }

    func state(at point: CGPoint) -> State {
        guard let scene = scene else {
            fatalError("obstacle is not on scene")
        }
        
        let lPoint = convert(point, from: scene)
        
        for obstacle in parts() {
            if obstacle.node.scene?.contains(lPoint) ?? false {
                return obstacle.state(at: point)
            }
        }
        fatalError("state not found")
    }

    func parts() -> [Obstacle] {
        return self[String(describing: Obstacle.self)] as! [Obstacle]
    }
    
    func parent() -> Obstacle? {
        return parent as? Obstacle ?? nil
    }
    
}
