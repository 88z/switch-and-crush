//
//  OneActionSceneElement.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 15.11.2020.
//

import Foundation
import SpriteKit

class TrivialUISceneElement {
    let color: UIColor
    let delayBeforePresent: CGFloat
    let position: CGPoint
    let font = FONT(size: 24)
    let name: String
    
    init(position: CGPoint, color: UIColor, delayBeforePresent: CGFloat, name: String="") {
        self.color = color
        self.delayBeforePresent = delayBeforePresent
        self.position = position
        self.name = name
    }
}


