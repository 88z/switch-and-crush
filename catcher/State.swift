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
    case immortal
}

enum ColorScheme {
    case blueRed
    case greenYellow
    case enigma
    case darkorangeCornflower
    case deepBlueDarkGrey
    case pink
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
            case .greenYellow:
                return UIColor.green()
            case .enigma:
                return UIColor.kellyGreen()
            case .darkorangeCornflower:
                return UIColor.darkOrnage()
            case .deepBlueDarkGrey:
                return UIColor.darkGrey()
            case .pink:
                return UIColor.mauve()
            }
        case .second:
            switch scheme {
            case .blueRed:
                return UIColor.red()
            case .greenYellow:
                return UIColor.yellow()
            case .enigma:
                return UIColor.violet()
            case .darkorangeCornflower:
                return UIColor.cornflower()
            case .deepBlueDarkGrey:
                return UIColor.deepBlue()
            case .pink:
                return UIColor.magenta()
            }
        case .immortal:
            return UIColor.immortal()
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
        if state == .immortal {
            return .immortal
        } else if state == .first {
            return .second
        } else {
            return .first
        }
    }
}


class StateNode: SKShapeNode {
    private var stateValue = State.first
    let colorScheme: ColorScheme
    let blinkInterval: TimeInterval
    var blinkTimer: Timer?
    
    init(arcWithCenter center: CGPoint,
         radius: CGFloat,
         startAngle: CGFloat,
         endAngle: CGFloat,
         width: CGFloat,
         state: State,
         colorScheme: ColorScheme,
         blinkInterval: TimeInterval) {
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
        self.blinkInterval = blinkInterval
        super.init()
        self.path = path.cgPath

        self.state = state
        setupBlinking() 
    }

    init(rect: CGRect, state: State, colorScheme: ColorScheme, blinkInterval: TimeInterval) {
        self.blinkInterval = blinkInterval
        self.colorScheme = colorScheme
        super.init()
        self.path = CGPath(rect: rect, transform: nil)
        self.state = state
        setupBlinking()
        
    }
    init(circleOfRadius radius: CGFloat, state: State, colorScheme: ColorScheme, blinkInterval: TimeInterval) {
        self.blinkInterval = blinkInterval
        self.colorScheme = colorScheme
        super.init()
        self.path = CGPath.init(ellipseIn: CGRect(origin: CGPoint(x:-radius, y: -radius), size: CGSize(width: radius*2, height: radius*2)), transform: nil)
        self.state = state
        setupBlinking()
    }
    
    private func setupBlinking() {
        guard blinkInterval > 0 else {
            return
        }
        blinkTimer?.invalidate()
        blinkTimer = Timer.scheduledTimer(withTimeInterval: blinkInterval, repeats: true, block: { [weak self] _ in
            guard let currentState = self?.state else {
                return
            }
            self?.state = State.nextState(for: currentState)
        })
        blinkTimer?.fire()
    }
    
    override func removeFromParent() {
        blinkTimer?.invalidate()
        super.removeFromParent()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        state = State.nextState(for: state)
    }
    
}
