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
    case thinPlank
    case plankStack
    case squareStack
    case squareStackPart
}

protocol Obstacle {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    func state(at point:CGPoint) -> State
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
    
}
