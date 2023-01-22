//
//  UIConstants.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 08.07.2022.
//

import Foundation
import SpriteKit
import UIKit
import LanguageManager_iOS

let UI_BUTTON_HEIGHT:CGFloat = 61
let UI_BUTTON_WIDTH:CGFloat = 252
let UI_BUTTON_BOTTOM_OFFSET:CGFloat = 154
let UI_VERTICAL_SPACE_BETWEEN_BUTTONS:CGFloat = 87
let UI_TITLE_TOP_OFFSET:CGFloat = 200
func FONT(size: CGFloat) -> UIFont {
    if LanguageManager.shared.currentLanguage == .en {
        return UIFont(name: "MajorMonoDisplay-Regular", size: size)!
    } else {
        return UIFont(name: "AlegreyaSansSC-Light", size: size)!
    }
    
}

let SQUARE_OBSTACLE_SIDE:CGFloat = 82
let CIRCLE_OBSTACLE_RADIUS:CGFloat = 64
let PLANK_OBSTACLE_HEIGHT:CGFloat = 14
let ARC_OBSTACLE_THICKNESS:CGFloat = 7
let PLANK_ATOM_SIZE: CGFloat = 7

let ATOM_NODE_NAME = "atom"

