//
//  OneActionSceneElement.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 15.11.2020.
//

import Foundation
import SpriteKit

class UISceneElement {
    let position: CGPoint
    let color: UIColor
    let delayBeforePresent: Int
    
    init(position: CGPoint, color: UIColor, delayBeforePresent: Int) {
        self.position = position
        self.color = color
        self.delayBeforePresent = delayBeforePresent
    }
}


