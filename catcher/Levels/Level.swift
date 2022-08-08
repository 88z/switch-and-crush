//
//  Level.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

struct Level {
    let obstacleTypes: [ObstacleType]
    let initialSpeed: CGFloat
    let acceleration: CGFloat
    let name: String
    let initialState:State
    let userInterationEnabled:Bool
    let colorScheme: ColorScheme
}
