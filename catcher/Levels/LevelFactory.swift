//
//  LevelFactory.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class LevelFactory {
    func level1() -> Level {
        return Level(obstacleCount: 30,
                     initialSpeed: 300,
                     acceleration: 10,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true)
    }
    
    
    
}
