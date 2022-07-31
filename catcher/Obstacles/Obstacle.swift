//
//  ObstaclePlank.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.07.2022.
//

import Foundation
import SpriteKit

enum Speed {
    case none
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
    case fragmentedRing(segmentsCount: Int, rotationSpeed: Speed)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool)
    case solidRingPart
    case arcObstacle
}


protocol Obstacle: AnyObject {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    var isSolid: Bool { get }
    func onAddedToScene()
    func state(at point:CGPoint, isContactTest:Bool) -> State?
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
    func willBeShattered()
    var firstSolidParent: Obstacle { get }
    func dummyForShattering() -> SKNode
}

extension Obstacle {
    var firstSolidParent: Obstacle {
        get {
            var parent:Obstacle = self
            while parent.parent()?.isSolid ?? false {
                parent = parent.parent()!
            }
            return parent
        }
    }
}
