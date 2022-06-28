//
//  OneActionSceneElement.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 15.11.2020.
//

import Foundation
import SpriteKit

class OneActionSceneElement {
    let position: CGPoint
    let color: UIColor
    let delayBeforePresent: Int
    init(position: CGPoint, color: UIColor, delayBeforePresent: Int) {
        self.position = position
        self.color = color
        self.delayBeforePresent = delayBeforePresent
    }
}

class OneActionSceneText: OneActionSceneElement {
    let text: String
    let font: UIFont
    init(position: CGPoint, color: UIColor, delayBeforePresent: Int, text:String, font: UIFont) {
        self.text = text
        self.font = font
        super.init(position: position, color: color, delayBeforePresent: delayBeforePresent)
    }
    
    convenience init(position: CGPoint, delayBeforePresent: Int, text:String) {
        self.init(position: position, color: .white, delayBeforePresent: delayBeforePresent, text: text, font: UIFont(name: "RobotoMono-Regular", size: 24)!)
    }
}
