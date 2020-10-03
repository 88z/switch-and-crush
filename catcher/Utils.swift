//
//  utils.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import Foundation
import CoreGraphics

func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y))
}
