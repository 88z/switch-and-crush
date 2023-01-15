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
        let acceleration = 0
        for _ in 0..<100{
            obstacleTypes.append([
//                ObstacleType.plank(state: State.random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: true, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
                ObstacleType.gatePlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.plankStack(blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: true, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: false, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.plank(state: .random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0)],
                     capacity: -1,
                     initialSpeed: 100,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 25
        for _ in 0..<15 {
            obstacleTypes.append(.plank(state: .random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(state: .random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0)],
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
                .twoStatePlank(isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
            ].randomElement()!)
        }
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [[
                        .twoStatePlank(isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0)
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
        let acceleration = 10
        let spaceShrinkValue = 3
        
        for i in 0..<15 {
            obstacleTypes.append([.pendulumPlank(partsCount: 2,
                                                 swingSpeed: .medium,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200) - i*spaceShrinkValue),
                                                 acceleration: acceleration),
                                  .twoStatePlank(isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200) - i*spaceShrinkValue),
                                                 acceleration: acceleration)].randomElement()!)
        }
        
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pendulumPlank(partsCount: 2,
                                                           swingSpeed: .medium,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                           acceleration: 0)],
                     capacity: 15,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level4() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        
        for _ in 0..<10 {
            obstacleTypes.append([.pendulumPlank(partsCount: 2,
                                                 swingSpeed: .fast,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                 acceleration: acceleration)].randomElement()!)
        }
        
        
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pendulumPlank(partsCount: 2,
                                                           swingSpeed: .fast,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                           acceleration: 0)],
                     capacity: 10,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level5() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 13
        let capacity = 15
        for _ in 0..<capacity {
            obstacleTypes.append(.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: 150, acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: 150, acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func  level6() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 8
        let spaceShrink = 4
        let capacity = 15
        for i in 0..<capacity {
            obstacleTypes.append(.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: Bool.random(), isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200) - i*spaceShrink), acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level7() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let spaceShrink = 5
        let capacity = 10
        for i in 0..<capacity {
            obstacleTypes.append(.carouselPlank(partsCount: 6, carouselSpeed: .medium, directionRight: Bool.random(), isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200) - i*spaceShrink), acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 6, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func bigRandomLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 3
        let spaceShrink = 2
        let capacity = 30
        for i in 0..<capacity {
            let spaceAfter = CGFloat(randomBetween(150, and: 200) - i*spaceShrink)
            obstacleTypes.append([.carouselPlank(partsCount: 4,
                                                 carouselSpeed: .medium,
                                                 directionRight: Bool.random(),
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: spaceAfter,
                                                 acceleration: acceleration),
                                  .pendulumPlank(partsCount: 2,
                                                 swingSpeed: .medium,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: spaceAfter,
                                                 acceleration: acceleration),
                                  .gatePlank(swingSpeed: .slow,
                                             isStacked: false,
                                             blinkInterval: 0,
                                             spaceAfter: spaceAfter,
                                             acceleration: acceleration),
                                  .twoStatePlank(isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: spaceAfter,
                                                 acceleration: acceleration),
                                  .plank(state: .random(),
                                         blinkInterval: 0,
                                         spaceAfter: spaceAfter,
                                         acceleration: acceleration)
                                  
            ].randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 4,
                                                         carouselSpeed: .medium,
                                                         directionRight: Bool.random(),
                                                         isStacked: false,
                                                         blinkInterval: 0,
                                                         spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                         acceleration: 0),
                                          .pendulumPlank(partsCount: 2,
                                                         swingSpeed: .medium,
                                                         isStacked: false,
                                                         blinkInterval: 0,
                                                         spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                         acceleration: 0),
                                          .gatePlank(swingSpeed: .slow,
                                                     isStacked: false,
                                                     blinkInterval: 0,
                                                     spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                     acceleration: 0),
                     ],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func pingPongLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 15
        let spaceShrink = 5
        for i in 0..<10 {
            obstacleTypes.append(.pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink), acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pingPongPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0)],
                     capacity: 10,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level10() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 15
        let spaceShrink = 5
        for i in 0..<10 {
            obstacleTypes.append([.pingPongPlank(swingSpeed: .fast,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                                 acceleration: acceleration),
                                  .gatePlank(swingSpeed: .slow,
                                             isStacked: false,
                                             blinkInterval: 0,
                                             spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                             acceleration: acceleration)]
                .randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pingPongPlank(swingSpeed: .medium,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                           acceleration: 0),
                                            .gatePlank(swingSpeed: .slow,
                                                       isStacked: false,
                                                       blinkInterval: 0,
                                                       spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                       acceleration: 0)],
                     capacity: 10,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level11() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 15
        let spaceShrink = 7
        for i in 0..<10 {
            obstacleTypes.append([.carouselPlank(partsCount: 6,
                                                 carouselSpeed: .medium,
                                                 directionRight: Bool.random(),
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                                 acceleration: acceleration),
                                  .pingPongPlank(swingSpeed: .fast,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                                 acceleration: acceleration),
                                  .gatePlank(swingSpeed: .slow,
                                             isStacked: false,
                                             blinkInterval: 0,
                                             spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                             acceleration: acceleration)]
                .randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pingPongPlank(swingSpeed: .medium,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                           acceleration: 0),
                                            .gatePlank(swingSpeed: .slow,
                                                       isStacked: false,
                                                       blinkInterval: 0,
                                                       spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                       acceleration: 0),
                                            .carouselPlank(partsCount: 6,
                                                         carouselSpeed: .medium,
                                                         directionRight: Bool.random(),
                                                         isStacked: false,
                                                         blinkInterval: 0,
                                                         spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                         acceleration: acceleration)],
                     capacity: 10,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level12() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 25
        for _ in 0..<capacity {
            obstacleTypes.append([.animatedRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                               acceleration: acceleration),
                                  .plank(state: .random(),
                                         blinkInterval: 0,
                                         spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                         acceleration: acceleration)]
                                 
                .randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.animatedRing(segmentsCount: 4,
                                                          rotationSpeed: .medium,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0),
                                            .plank(state: .random(),
                                                   blinkInterval: 0,
                                                   spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                                   acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func ringLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 10
        for _ in 0..<capacity {
            obstacleTypes.append(.animatedRing(segmentsCount: 4,
                                               rotationSpeed: .fast,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                               acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.animatedRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func crazyRingLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 0
        let capacity = 7
        for _ in 0..<capacity {
            obstacleTypes.append(.animatedRing(segmentsCount: 4,
                                               rotationSpeed: .crazy,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(200, and: 300)),
                                               acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.animatedRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(200, and: 300)),
                                                          acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
}
