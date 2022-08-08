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

enum ColorScheme {
    case blueRed
    case mint
}

extension ColorScheme {
    static func defaultScheme() -> ColorScheme {
        return .blueRed
    }
    
}

extension State {
    func color(for scheme:ColorScheme) -> UIColor {
        switch self {
        case .first:
            switch scheme {
            case .blueRed:
                return UIColor.blue()
            case .mint:
                return UIColor.green()
            }
        case .second:
            switch scheme {
            case .blueRed:
                return UIColor.red()
            case .mint:
                return UIColor.isabelline()
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
    
    static func nextState(for state:State) -> State {
        if state == .first {
            return .second
        } else {
            return .first
        }
    }
}


class StateNode: SKShapeNode {
    private var stateValue = State.first
    let colorScheme: ColorScheme
    
    init(arcWithCenter center: CGPoint,
         radius: CGFloat,
         startAngle: CGFloat,
         endAngle: CGFloat,
         width: CGFloat,
         state: State,
         colorScheme: ColorScheme) {
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        let innerPath = UIBezierPath()
        let innerRadius = radius-width
        innerPath.addArc(withCenter: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        let innerCircleEnd = innerPath.currentPoint

        path.addLine(to: innerCircleEnd)
        path.addArc(withCenter: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        path.close()
        self.colorScheme = colorScheme
        super.init()
        self.path = path.cgPath

        self.state = state
    }

    init(rect: CGRect, state: State, colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
        super.init()
        self.path = CGPath(rect: rect, transform: nil)
        self.state = state
        
    }
    init(circleOfRadius radius: CGFloat, state: State, colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
        super.init()
        self.path = CGPath.init(ellipseIn: CGRect(origin: CGPoint(x:-radius, y: -radius), size: CGSize(width: radius*2, height: radius*2)), transform: nil)
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var state: State {
        set (newValue) {
            stateValue = newValue
            fillColor = newValue.color(for: colorScheme)
            strokeColor = fillColor
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
