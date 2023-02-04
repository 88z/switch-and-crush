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
let SOLID_RING_RADIUS:CGFloat = 64
let SOLID_RING_RADIUS_OUTER:CGFloat = 140
let FRAGMENTED_RING_RADIUS_OUTER:CGFloat = 161
let SOLID_RING_WITH_BRICK_RADIUS: CGFloat = 77
let FRAGMENTED_RING_RADIUS: CGFloat = 96

let PLANK_OBSTACLE_HEIGHT:CGFloat = 14
let STONE_OBSTACLE_HEIGHT:CGFloat = 35
let ARC_OBSTACLE_THICKNESS:CGFloat = 7
let PLANK_ATOM_SIZE: CGFloat = 7

let ATOM_NODE_NAME = "atom"

let ENDLESS_LEVEL_TITLE = "∞"

func ENDLESS_LEVEL_TITLE_FONT(size: CGFloat) -> UIFont {
    return UIFont(name: "NotoSansJP-Thin", size: size)!
}
