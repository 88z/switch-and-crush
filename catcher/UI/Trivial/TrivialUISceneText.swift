//
//  UISceneText.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.07.2022.
//

import Foundation
import SpriteKit

class TrivialUISceneText: TrivialUISceneElement {
    let text: String
    init(position: CGPoint, color: UIColor, delayBeforePresent: Int, text:String) {
        self.text = text
        super.init(position: position, color: color, delayBeforePresent: delayBeforePresent, name: text)
    }
    
    convenience init(position: CGPoint, delayBeforePresent: Int, text:String) {
        self.init(position: position, color: UIColor.text(), delayBeforePresent: delayBeforePresent, text: text)
    }
    

}
