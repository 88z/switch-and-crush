//
//  LevelFactory.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 12.07.2022.
//

import Foundation
import SpriteKit

class ChallengingLevelFactory: LevelFactory {
    
    var levels: [Level] {
        return [
            level1(),
            level2(),
            level3(),
            pendulumLevel(),
            plankAndPlankLevel(),
            level6(),
            level7(),
            pendulumAndPlankLevel(),
            level9(),
            bigRandomLevel(),
            pingPongLevel(),
            plankAndCarouselLevel(),
            level13(),
            level14(),
            plankAndGateLevel(),
            level16(),
            ringLevel(),
            crazyRingLevel(),
            plankAndRingLevel(),
            level20(),
            level21(),
            pendulumAndCarouselLevel(),
            chainLevel(),
            level24(),
            fragmentedRingLevel(),
            pingPongAndPendulumLevel(),
            endlessLevel()
        ]
    }
    
    func endlessLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        for _ in 0..<10{
            obstacleTypes.append([
//                ObstacleType.plank(state: State.random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: true, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.gatePlank(swingSpeed: .slow, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: true, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.twoStatePlank(isStacked: false, blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.plankStack(blinkInterval: 0, acceleration: acceleration),
//                ObstacleType.fragmentedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: true, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
//                ObstacleType.animatedRing(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: true, isStacked: false, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration),
                ObstacleType.ringWithBrick(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: .random(), isStacked: false, spaceAfter: 200, acceleration: acceleration)
//                ObstacleType.doubleRingWithBrick(outerSegmentsCount: 12, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: Bool.random(), innerDirectionClockwise: Bool.random(), spaceAfter: 200, acceleration: acceleration)
//                ObstacleType.fragmentedDoubleRing(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: Bool.random(), innerDirectionClockwise: Bool.random(), spaceAfter: 200, acceleration: acceleration)
            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.ringWithBrick(segmentsCount: 4, rotationSpeed: .slow, directionClockwise: .random(), isStacked: false, spaceAfter: 200, acceleration: 0)],
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
                     colorScheme: .greenYellow)
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
                     colorScheme: .enigma)
    }
    
    func pendulumLevel() -> Level {
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
    
    func plankAndPlankLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 20
        let spaceShrink = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.plank(state: .random(),
                                                    blinkInterval: 0,
                                                    spaceAfter: 50,
                                                    acceleration: 0),
                                             .plank(state: .random(),
                                                    blinkInterval: 0,
                                                    spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                    acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(state: .random(),
                                                   blinkInterval: 0,
                                                   spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                   acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level6() -> Level {
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
                     colorScheme: .darkorangeCornflower)
    }
    
    func  level7() -> Level {
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
                     colorScheme: .deepBlueDarkGrey)
    }
    
    func level9() -> Level {
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
    
    func crazyCarouselLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let capacity = 7
        for _ in 0..<capacity {
            obstacleTypes.append(.carouselPlank(partsCount: 4, carouselSpeed: .crazy, directionRight: .random(), isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(200, and: 300)), acceleration: 0))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 4, carouselSpeed: .crazy, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(200, and: 300)), acceleration: 0)],
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
    
    func plankAndCarouselLevel() -> Level{
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 4
        let capacity = 14
        let spaceShrink = 5
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[
                .carouselPlank(partsCount: 4,
                               carouselSpeed: .medium,
                               directionRight: .random(),
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter: 50,
                               acceleration: acceleration),
                .plank(state: .random(),
                       blinkInterval: 0,
                       spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                       acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 4,
                                                          carouselSpeed: .medium,
                                                          directionRight: .random(),
                                                          isStacked: false,
                                                          blinkInterval: 0,
                                                          spaceAfter: CGFloat(randomBetween(150, and: 200) ),
                                                          acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 220,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func pendulumAndPlankLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 16
        let spaceShrink = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.pendulumPlank(partsCount: 2,
                                                            swingSpeed: .medium,
                                                            isStacked: false,
                                                            blinkInterval: 0,
                                                            spaceAfter: 50,
                                                            acceleration: 0),
                                             .plank(state: .random(),
                                                    blinkInterval: 0,
                                                    spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                    acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(state: .random(),
                                                   blinkInterval: 0,
                                                   spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                   acceleration: 0)],
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
            obstacleTypes.append(.pingPongPlank(swingSpeed: .fast,
                                                isStacked: false,
                                                blinkInterval: 0,
                                                spaceAfter: CGFloat(randomBetween(150, and: 200)-i*spaceShrink),
                                                acceleration: acceleration))
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
    
    func level13() -> Level {
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
    
    func level14() -> Level {
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
    
    func plankAndGateLevel() -> Level{
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 14
        let spaceShrink = 5
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[
                                             .gatePlank(swingSpeed: .slow,
                                                        isStacked: false,
                                                        blinkInterval: 0,
                                                        spaceAfter: 50,
                                                        acceleration: 0),
                                             .plank(state: .random(),
                                                    blinkInterval: 0,
                                                    spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                    acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.gatePlank(swingSpeed: .slow,
                                                       isStacked: false,
                                                       blinkInterval: 0,
                                                       spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                       acceleration: 0),
                                            .plank(state: .random(),
                                                   blinkInterval: 0,
                                                   spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                   acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level16() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 25
        for _ in 0..<capacity {
            obstacleTypes.append([.solidRing(segmentsCount: 4,
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
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
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
            obstacleTypes.append(.solidRing(segmentsCount: 4,
                                               rotationSpeed: .fast,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(75, and: 125)),
                                               acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(75, and: 125)),
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
            obstacleTypes.append(.solidRing(segmentsCount: 4,
                                               rotationSpeed: .crazy,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(200, and: 300)),
                                               acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .crazy,
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
    
    func plankAndRingLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 20
        let shrinkValue = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.solidRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: 10,
                                               acceleration: 0),
                                  .plank(state: .random(),
                                         blinkInterval: 0,
                                         spaceAfter: CGFloat(randomBetween(200, and: 250) - i*shrinkValue),
                                         acceleration: acceleration)])
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
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
    
    func level20() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 15
        for _ in 0..<capacity {
            obstacleTypes.append([.solidRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(75, and: 125)),
                                               acceleration: acceleration),
                                  .carouselPlank(partsCount: 4,
                                                 carouselSpeed: .medium,
                                                 directionRight: Bool.random(),
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                                 acceleration: acceleration)]
                                 
                .randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0),
                                            .carouselPlank(partsCount: 4,
                                                           carouselSpeed: .fast,
                                                           directionRight: Bool.random(),
                                                           isStacked: false,
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
    
    func level21() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 10
        let spaceShrink = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.solidRing(segmentsCount: 4,
                                               rotationSpeed: .fast,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                               acceleration: acceleration),
                                  .pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)-spaceShrink*i), acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .fast,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0),
                                            .pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func pendulumAndCarouselLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 14
        let spaceShrink = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.carouselPlank(partsCount: 4,
                                                            carouselSpeed: .slow,
                                                            directionRight: .random(),
                                                            isStacked: false,
                                                            blinkInterval: 0,
                                                            spaceAfter: 50,
                                                            acceleration: acceleration),
                                            .pendulumPlank(partsCount: 2,
                                                            swingSpeed: .fast,
                                                            isStacked: false,
                                                            blinkInterval: 0,
                                                            spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                            acceleration: 0),
                                             ]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(state: .random(),
                                                   blinkInterval: 0,
                                                   spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                   acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func chainLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 10
        for _ in 0..<capacity {
            obstacleTypes.append(.solidRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: -1,
                                               acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .medium,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: -1,
                                                          acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 150,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level24() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 7
        let capacity = 12
        let spaceShrink = 5
        for i in 0..<capacity/3 {
            obstacleTypes.append(contentsOf:[.solidRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: 50,
                                               acceleration: acceleration),
                                             .pingPongPlank(swingSpeed: .medium, isStacked: false, blinkInterval: 0, spaceAfter: 100, acceleration: acceleration),
                                             .carouselPlank(partsCount: 4, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(200, and: 250)-spaceShrink*i), acceleration: acceleration)]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .medium,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0),
                                            .pingPongPlank(swingSpeed: .fast, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0),
                                            .carouselPlank(partsCount: 6, carouselSpeed: .fast, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func fragmentedRingLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 10
        for _ in 0..<capacity {
            obstacleTypes.append(.fragmentedRing(segmentsCount: 4,
                                                 rotationSpeed: .fast,
                                                 directionClockwise: Bool.random(),
                                                 isStacked: false,
                                                 spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                                 acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.fragmentedRing(segmentsCount: 4,
                                                            rotationSpeed: .medium,
                                                            directionClockwise: Bool.random(),
                                                            isStacked: false,
                                                            spaceAfter: CGFloat(randomBetween(75, and: 125)),
                                                            acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func pingPongAndPendulumLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 12
        let spaceShrink = 10
        for i in 0..<capacity/2 {
            obstacleTypes.append(contentsOf:[.pendulumPlank(partsCount: 2,
                                                            swingSpeed: .fast,
                                                            isStacked: false,
                                                            blinkInterval: 0,
                                                            spaceAfter: 50,
                                                            acceleration: 0),
                                            .pingPongPlank(swingSpeed: .fast,
                                                            isStacked: false,
                                                            blinkInterval: 0,
                                                            spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                            acceleration: acceleration),
                                             ]
                                 )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.pendulumPlank(partsCount: 2,
                                                           swingSpeed: .fast,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(200, and: 250)),
                                                           acceleration: 0),
                                           .pingPongPlank(swingSpeed: .fast,
                                                           isStacked: false,
                                                           blinkInterval: 0,
                                                           spaceAfter: CGFloat(randomBetween(200, and: 250)),
                                                           acceleration: 0),],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
}

