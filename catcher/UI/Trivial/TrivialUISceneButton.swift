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
    let width: CGFloat
    
    init(position: CGPoint, color: UIColor, delayBeforePresent: CGFloat, text:String, width:CGFloat=0, name:String="") {
        self.text = text
        self.width = width
        super.init(position: position, color: color, delayBeforePresent: delayBeforePresent, name: name)
    }
    
}


