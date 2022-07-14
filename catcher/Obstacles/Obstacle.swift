//
//  ObstaclePlank.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

enum ObstacleType {
    case plank
    case square
    case twoColorPlank
    case animatedTwoColorPlank
}

protocol Obstacle {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    func state(at point:CGPoint) -> State
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
    
}
