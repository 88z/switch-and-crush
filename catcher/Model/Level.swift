//
//  Level.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

struct Level {
    let initialObstacleTypes: [ObstacleType]
    let obstacleTypesForTail: [ObstacleType]
    let capacity: Int
    let initialSpeed: CGFloat
    let name: String
    let isBoss: Bool
    let initialState:State
    let userInterationEnabled:Bool
    let colorScheme: ColorScheme
    var isEndless:Bool {
        return capacity < 0
    }
    
}
