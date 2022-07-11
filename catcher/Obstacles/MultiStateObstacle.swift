//
//  ObstacleContainer.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

class MultiStateObstacle: SKNode, Obstacle {
    var node: SKNode {
        return self
    }
    
    var velocity: CGFloat {
        get {
            return parts().first?.velocity ?? 0
        }
        
        set {
            for var obstacle in parts() {
                obstacle.velocity = newValue
            }
        }
    }

    func state(at point: CGPoint) -> State {
        guard let scene = scene else {
            fatalError("obstacle ins not on scene")
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
