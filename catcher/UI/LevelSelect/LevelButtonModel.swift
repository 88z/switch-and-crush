//
//  LevelSelectButtonViewModel.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 15.08.2022.
//

import Foundation
import CoreGraphics

enum LevelButtonState {
    case completed
    case locked
    case current
}

struct LevelButtonModel {
    let isEnabled: Bool
    let title: String
    let state: LevelButtonState
    let completionPart: CGFloat
}
