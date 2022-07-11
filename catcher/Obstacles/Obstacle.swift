//
//  ObstaclePlank.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

protocol Obstacle {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    func state(at point:CGPoint) -> State
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
}
