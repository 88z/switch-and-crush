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
        for _ in 0..<30{
            obstacleTypes.append([
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true),
//                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 1),
//                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 1),
//                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 1),
                ObstacleType.plank(blinkInterval: 3),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, blinkInterval: 1),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false),
//                ObstacleType.arcStack,
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false)
            ].randomElement()! )
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 150,
                     acceleration: 0,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<30 {
            obstacleTypes.append(.plank(blinkInterval: 0))
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    
    func level2() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<5 {
            obstacleTypes.append(.plank(blinkInterval: 0))
        }
        for _ in 0..<25 {
            obstacleTypes.append([
                ObstacleType.plank(blinkInterval: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0)
            ].randomElement()! )
           
        }
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level3() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<3 {
            obstacleTypes.append(.plank(blinkInterval: 0))
        }
        
        for _ in 0..<10 {
            obstacleTypes.append([
                ObstacleType.plank(blinkInterval: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0),
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0),
                ObstacleType.pendulumPlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0),
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.pendulumPlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0),
            ].randomElement()! )
        }
        
        return Level(obstacleTypes: obstacleTypes,
                     initialSpeed: 200,
                     acceleration: 5,
                     name:"default",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
}
