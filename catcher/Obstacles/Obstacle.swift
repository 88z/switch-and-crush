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
    case plank(state: State, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case twoStatePlank(isStacked:Bool, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case pendulumPlank(partsCount: Int, swingSpeed: Speed, isStacked:Bool, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case pingPongPlank(swingSpeed: Speed, isStacked:Bool, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case thinPlank(state: State, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case plankStack(blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case solidRing(segmentsCount: Int, rotationSpeed: Speed, directionClockwise: Bool, isStacked: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedRing(segmentsCount: Int, rotationSpeed: Speed, directionClockwise: Bool, isStacked: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool, isStacked: Bool, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case arc(blinkInterval: TimeInterval, acceleration: CGFloat)
    case arcStack(blinkInterval: TimeInterval, acceleration: CGFloat)
    case gatePlank(swingSpeed: Speed, isStacked:Bool, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case brick(state: State, blinkInterval: TimeInterval, spaceAfter: CGFloat, acceleration: CGFloat)
    case ringWithBrick(segmentsCount: Int, rotationSpeed: Speed, directionClockwise: Bool, isStacked: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case doubleRing(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case doubleRingWithBrick(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedRingWithBrick(segmentsCount: Int, rotationSpeed: Speed, directionClockwise: Bool, isStacked: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedDoubleRing(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedDoubleRingWithBrick(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedRingSolidRing(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case solidRingFragmentedRing(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case fragmentedRingSolidRingWithBrick(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    case solidRingFragmentedRingWithBrick(outerSegmentsCount: Int, innerSegmentsCount: Int, outerRotationSpeed: Speed, innerRotationSpeed: Speed, outerIsStacked: Bool, innerIsStacked: Bool, outerDirectionClockwise: Bool, innerDirectionClockwise: Bool, spaceAfter: CGFloat, acceleration: CGFloat)
    
}

protocol Obstacle: AnyObject {
    var velocity: CGFloat { get set }
    var spaceAfter: CGFloat { get }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    var isSolid: Bool { get }
    var acceleration: CGFloat { get }
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
    
    var isLastPart: Bool {
        get {
            guard let parts = parent()?.parts() else {
                return false
            }
            if parts.count == 1 {
                return parts.first?.node == self.node
            }
            return false
        }
    }
    
    func remove () {
        if isLastPart {
            parent()?.remove()
        } else {
            node.removeFromParent()
        }
    }
}
