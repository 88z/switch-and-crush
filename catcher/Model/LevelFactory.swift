//
//  LevelFactory.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class LevelFactory {
    
    func endlessLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        for _ in 0..<100{
            obstacleTypes.append([
//                ObstacleType.plank(blinkInterval: 0, acceleration: acceleration),
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, acceleration: acceleration),
//                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.plankStack(blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false, acceleration: acceleration)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(blinkInterval: 0, acceleration: 0)],
                     capacity: -1,
                     initialSpeed: 100,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func backgorundLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<100{
            obstacleTypes.append([
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, acceleration: 0),
                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0, acceleration: 0),
                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0, acceleration: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: 0),
                ObstacleType.plank(blinkInterval: 0, acceleration: 0),
                ObstacleType.plankStack(blinkInterval: 0, acceleration: 0),
                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, blinkInterval: 0, acceleration: 0),
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false, acceleration: 0)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(blinkInterval: 0, acceleration: 0)],
                     capacity: -1,
                     initialSpeed: 250,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 25
        for _ in 0..<15 {
            obstacleTypes.append(.plank(blinkInterval: 0, acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(blinkInterval: 0, acceleration: 0)],
                     capacity: 15,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    
    func level2() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 25

        for _ in 0..<10 {
            obstacleTypes.append([
                .twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: acceleration),
            ].randomElement()!)
        }
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [[
                        .twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: 0)
                     ].randomElement()!],
                     capacity: 15,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level3() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<3 {
            obstacleTypes.append(.plank(blinkInterval: 0, acceleration: 0))
        }
        
        for _ in 0..<10 {
            obstacleTypes.append([
                ObstacleType.plank(blinkInterval: 0, acceleration: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: 0),
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: 0),
                ObstacleType.pendulumPlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0, acceleration: 0),
            ].randomElement()! )
        }
        
        for _ in 0..<5 {
            obstacleTypes.append([
                ObstacleType.pendulumPlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0, acceleration: 0),
            ].randomElement()! )
        }
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(blinkInterval: 0, acceleration: 0)],
                     capacity: 10,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
}
