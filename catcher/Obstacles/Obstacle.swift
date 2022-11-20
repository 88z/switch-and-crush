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
    case plank(blinkInterval: TimeInterval, acceleration: Int)
    case twoStatePlank(isStacked:Bool, blinkInterval: TimeInterval, acceleration: Int)
    case pendulumPlank(partsCount: Int, swingSpeed: Speed, isStacked:Bool, blinkInterval: TimeInterval, acceleration: Int)
    case thinPlank(blinkInterval: TimeInterval, acceleration: Int)
    case plankStack(blinkInterval: TimeInterval, acceleration: Int)
    case animatedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool, acceleration: Int)
    case fragmentedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool, blinkInterval: TimeInterval, acceleration: Int)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool, isStacked: Bool, blinkInterval: TimeInterval, acceleration: Int)
    case arc(blinkInterval: TimeInterval, acceleration: Int)
    case arcStack(blinkInterval: TimeInterval, acceleration: Int)
}

protocol Obstacle: AnyObject {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    var isSolid: Bool { get }
    var acceleration: Int { get }
    func onAddedToScene()
    func state(at point:CGPoint) -> State?
    func contactTest(at point: CGPoint, state: State) -> Bool
    func parts() -> [Obstacle]
    func parent() -> Obstacle?
    func willBeShattered()
    var firstSolidParent: Obstacle { get }
    func shatteringDummy() -> SKNode
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
