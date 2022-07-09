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
    var frame: CGRect { get }
    var scene: SKScene? { get }
    func removeFromParent()
    func state(at point:CGPoint) -> State
}
