//
//  LevelFactory.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class LevelFactory {
    func backgorundLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<100{
            obstacleTypes.append([
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true),
                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0),
                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0),
                ObstacleType.plank(blinkInterval: 0),
                ObstacleType.plankStack(blinkInterval: 0),
                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, blinkInterval: 0),
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(blinkInterval: 0)],
                     capacity: -1,
                     initialSpeed: 250,
                     acceleration: 10,
                     name:"0",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    func infiniteLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<100{
            obstacleTypes.append([
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true),
//                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0),
//                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0),
//                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0),
//                ObstacleType.plank(blinkInterval: 0),
//                ObstacleType.plankStack(blinkInterval: 0),
                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .none, isStacked: true, blinkInterval: 0),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false, blinkInterval: 0),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(blinkInterval: 0)],
                     capacity: -1,
                     initialSpeed: 100,
                     acceleration: 10,
                     name:"0",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level0() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<100{
            obstacleTypes.append([
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true),
                ObstacleType.pendulumPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0),
                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0),
                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0),
                ObstacleType.plank(blinkInterval: 0),
                ObstacleType.plankStack(blinkInterval: 0),
                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: true, blinkInterval: 0),
                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, isStacked: false)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(blinkInterval: 0)],
                     capacity: 100,
                     initialSpeed: 200,
                     acceleration: 10,
                     name:"0",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        for _ in 0..<30 {
            obstacleTypes.append(.twoStatePlank(isStacked: false, blinkInterval: 0))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.twoStatePlank(isStacked: false, blinkInterval: 0)],
                     capacity: 10,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"1",
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
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(blinkInterval: 0)],
                     capacity: 100,
                     initialSpeed: 200,
                     acceleration: 7,
                     name:"2",
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
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(blinkInterval: 0)],
                     capacity: 100,
                     initialSpeed: 200,
                     acceleration: 5,
                     name:"3",
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
}
