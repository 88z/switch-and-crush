//
//  LevelFactory.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class LevelFactory {
    
    func level0() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<20 {
            obstacleTypes.append([
                ObstacleType.carousel2,
//                ObstacleType.animatedTwoColorPlank
            ].randomElement()! )
           
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 150,
                     acceleration: 0,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<30 {
            obstacleTypes.append(.plank)
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true)
    }
    
    
    func level2() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<5 {
            obstacleTypes.append(.plank)
        }
        for _ in 0..<25 {
            obstacleTypes.append([
                ObstacleType.plank,
                ObstacleType.twoColorPlank
            ].randomElement()! )
           
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true)
    }
    
    func level3() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<3 {
            obstacleTypes.append(.plank)
        }
        
        for _ in 0..<10 {
            obstacleTypes.append([
                ObstacleType.plank,
                ObstacleType.twoColorPlank,
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.twoColorPlank,
                ObstacleType.animatedTwoColorPlank,
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.animatedTwoColorPlank,
            ].randomElement()! )
        }
        
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 5,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true)
    }
    
    
    
    
}
