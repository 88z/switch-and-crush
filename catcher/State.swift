//
//  State.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

enum State {
    case first
    case second
}

extension State {
    var color:UIColor {
        get {
            switch self {
            case .first:
                return UIColor.first()
            case .second:
                return UIColor.second()
            }
        }
    }
    
    static func random() -> State {
        if Bool.random() {
            return .first
        } else {
            return .second
        }
    }
}


class StateNode: SKShapeNode {
    private var stateValue = State.first
    
    var state: State {
        set (newValue) {
            stateValue = newValue
            fillColor = newValue.color
            strokeColor = newValue.color
        }
        get {
            return stateValue
        }
    }
    
    func toggleState() {
        if state == .first {
            state = .second
        } else {
            state = .first
        }
    }
    
}
