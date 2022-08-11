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
    case plank(blinkInterval: TimeInterval)
    case twoStatePlank(isStacked:Bool, blinkInterval: TimeInterval)
    case pendulumPlank(swingSpeed: Speed, isStacked:Bool, blinkInterval: TimeInterval)
    case thinPlank(blinkInterval: TimeInterval)
    case plankStack(blinkInterval: TimeInterval)
    case animatedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool, blinkInterval: TimeInterval)
    case fragmentedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool, blinkInterval: TimeInterval)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool, isStacked: Bool, blinkInterval: TimeInterval)
    case arc(blinkInterval: TimeInterval)
    case arcStack(blinkInterval: TimeInterval)
}


extension ObstacleType {
    var pointNumber: Int {
        get {
            switch self {
            case .fragmentedRing(segmentsCount: _,
                                 rotationSpeed: _,
                                 isStacked: _,
                                 blinkInterval: _):
                return 2
            default:
                return 1
            }
        }
    }
    
    static func points(in types:[ObstacleType]) ->Int {
        return types.reduce(0) { partialResult, type in
            return partialResult + type.pointNumber
        }
    }
}

protocol Obstacle: AnyObject {
    var velocity: CGFloat { get set }
    var node: SKNode { get }
    var type: ObstacleType! { get }
    var isSolid: Bool { get }
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
