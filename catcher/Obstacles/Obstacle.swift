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
    case twoStatePlank(isStacked:Bool)
    case pendulumPlank(swingSpeed: Speed, isStacked:Bool)
    case thinPlank
    case plankStack
    case animatedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool)
    case fragmentedRing(segmentsCount: Int, rotationSpeed: Speed, isStacked: Bool)
    case carouselPlank(partsCount: Int, carouselSpeed: Speed, directionRight: Bool, isStacked: Bool)
    case arc
    case arcStack
}


extension ObstacleType {
    var pointNumber: Int {
        get {
            switch self {
            case .fragmentedRing(segmentsCount: _, rotationSpeed: _, isStacked: _):
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
    func state(at point:CGPoint, isContactTest:Bool) -> State?
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
