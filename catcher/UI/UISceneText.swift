//
//  UISceneText.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.07.2022.
//

import Foundation
import SpriteKit

class UISceneText: UISceneElement {
    let text: String
    let font: UIFont
    init(position: CGPoint, color: UIColor, delayBeforePresent: Int, text:String, font: UIFont) {
        self.text = text
        self.font = font
        super.init(position: position, color: color, delayBeforePresent: delayBeforePresent)
    }
    
    convenience init(position: CGPoint, delayBeforePresent: Int, text:String) {
        self.init(position: position, color: .white, delayBeforePresent: delayBeforePresent, text: text, font: UIFont(name: "MajorMonoDisplay-Regular", size: 24)!)
    }
}
