//
//  ObstaclePlank.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

enum Speed {
    case slow
    case medium
    case fast
    case crazy
}

enum ObstacleType: Equatable {
    case plank
    case twoStatePlank
    case pendulumPlank(swingSpeed: Speed)
    case thinPlank
    case plankStack
    case animatedRing(segmentsCount: Int, rotationSpeed: Speed)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool)
}


protocol Obstacle: AnyObject {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    func onAddedToScene()
    func state(at point:CGPoint) -> State?
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
    func willBeShattered()
}
