//
//  UISceneButton.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.07.2022.
//

import Foundation
import SpriteKit

class TrivialUISceneButton: TrivialUISceneElement {
    let text: String
    
    init(position: CGPoint, color: UIColor, delayBeforePresent: CGFloat, text:String, name:String="") {
        self.text = text
        super.init(position: position, color: color, delayBeforePresent: delayBeforePresent, name: name)
    }
    
    public convenience init(position: CGPoint, delayBeforePresent: CGFloat, text:String, name:String="") {
        self.init(position: position, color: .text(), delayBeforePresent: delayBeforePresent, text: text)
    }
}


