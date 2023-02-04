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
            level5(),
            level6(),
            pendulumAndPlankLevel(),
            level8(),
            bigRandomLevel(),
            pingPongLevel(),
            plankAndCarouselLevel(),
            level12(),
            level13(),
            plankAndGateLevel(),
            level15(),
            ringLevel(),
            crazyRingLevel(),
            plankAndRingLevel(),
            level19(),
            level20(),
            pendulumAndCarouselLevel(),
            chainLevel(),
            level23(),
            fragmentedRingLevel(),
            pingPongAndPendulumLevel(),
            level26(),
            level27(),
            ringWithBrickLevel(),
            doubleRingLevel(),
            level30(),
            bossLevel(),
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
//                ObstacleType.ringWithBrick(segmentsCount: 4, rotationSpeed: .medium, directionClockwise: .random(), isStacked: false, spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.doubleRingWithBrick(outerSegmentsCount: 12, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: Bool.random(), innerDirectionClockwise: Bool.random(), spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.fragmentedDoubleRing(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.fragmentedDoubleRingWithBrick(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.fragmentedRingSolidRing(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .fast, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.solidRingFragmentedRing(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
//                ObstacleType.fragmentedRingSolidRingWithBrick(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .fast, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
                ObstacleType.solidRingFragmentedRingWithBrick(outerSegmentsCount: 4, innerSegmentsCount: 4, outerRotationSpeed: .medium, innerRotationSpeed: .medium, outerIsStacked: false, innerIsStacked: false, outerDirectionClockwise: true, innerDirectionClockwise: false, spaceAfter: 200, acceleration: acceleration),
                

            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [ObstacleType.ringWithBrick(segmentsCount: 4, rotationSpeed: .slow, directionClockwise: .random(), isStacked: false, spaceAfter: 200, acceleration: 0)],
                     capacity: -1,
                     initialSpeed: 100,
                     name:#function,
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .pink)
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .darkorangeCornflower)
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .deepBlueDarkGrey)
    }
    
    func level8() -> Level {
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .india)
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .honey)
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .lava)
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level12() -> Level {
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level13() -> Level {
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level15() -> Level {
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
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level19() -> Level {
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level20() -> Level {
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
                     isBoss: false,
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level23() -> Level {
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func fragmentedRingLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 15
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
                     isBoss: false,
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level26() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 5
        let capacity = 25
        let spaceShrink = 4
        for i in 0..<capacity {
            obstacleTypes.append([.solidRing(segmentsCount: 4,
                                               rotationSpeed: .medium,
                                               directionClockwise: Bool.random(),
                                               isStacked: false,
                                               spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                               acceleration: acceleration),
                                  .pingPongPlank(swingSpeed: .fast,
                                                  isStacked: false,
                                                  blinkInterval: 0,
                                                  spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                  acceleration: acceleration),
                                  .pendulumPlank(partsCount: 2,
                                                  swingSpeed: .fast,
                                                  isStacked: false,
                                                  blinkInterval: 0,
                                                  spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                  acceleration: 0),
                                  .fragmentedRing(segmentsCount: 4,
                                                   rotationSpeed: .fast,
                                                   directionClockwise: Bool.random(),
                                                   isStacked: false,
                                                   spaceAfter: CGFloat(randomBetween(200, and: 250) - i*spaceShrink),
                                                   acceleration: acceleration),
                                  .carouselPlank(partsCount: 4,
                                                 carouselSpeed: .medium,
                                                 directionRight: true,
                                                 isStacked: false,
                                                 blinkInterval: 0,
                                                 spaceAfter: CGFloat(randomBetween(200, and: 250)-spaceShrink*i),
                                                 acceleration: acceleration)].randomElement()!)
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
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level27() -> Level {
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
                                  .fragmentedRing(segmentsCount: 4,
                                                   rotationSpeed: .medium,
                                                   directionClockwise: Bool.random(),
                                                   isStacked: false,
                                                   spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                                   acceleration: acceleration)].randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                          rotationSpeed: .medium,
                                                          directionClockwise: Bool.random(),
                                                          isStacked: false,
                                                          spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                          acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func ringWithBrickLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 12
        for _ in 0..<capacity {
            obstacleTypes.append(ObstacleType.ringWithBrick(segmentsCount: 6,
                                                            rotationSpeed: .medium,
                                                            directionClockwise: .random(),
                                                            isStacked: false,
                                                            spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                                            acceleration: acceleration))
                
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.ringWithBrick(segmentsCount: 4,
                                                           rotationSpeed: .medium,
                                                           directionClockwise: .random(),
                                                           isStacked: false,
                                                           spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                                           acceleration: acceleration)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func doubleRingLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 16
        for _ in 0..<capacity {
            obstacleTypes.append([.doubleRing(outerSegmentsCount: 8,
                                                         innerSegmentsCount: 4,
                                                         outerRotationSpeed: .slow,
                                                         innerRotationSpeed: .medium,
                                                         outerIsStacked: false,
                                                         innerIsStacked: false,
                                                         outerDirectionClockwise: .random(),
                                                         innerDirectionClockwise: .random(),
                                                         spaceAfter: 25,
                                                          acceleration: acceleration)].randomElement()!)
                
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.doubleRing(outerSegmentsCount: 8,
                                                        innerSegmentsCount: 4,
                                                        outerRotationSpeed: .slow,
                                                        innerRotationSpeed: .medium,
                                                        outerIsStacked: false,
                                                        innerIsStacked: false,
                                                        outerDirectionClockwise: .random(),
                                                        innerDirectionClockwise: .random(),
                                                        spaceAfter:25,
                                                        acceleration: acceleration)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level30() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration = 10
        let capacity = 15
        for _ in 0..<capacity {
            obstacleTypes.append([.doubleRing(outerSegmentsCount: 8,
                                                         innerSegmentsCount: 4,
                                                         outerRotationSpeed: .slow,
                                                         innerRotationSpeed: .medium,
                                                         outerIsStacked: false,
                                                         innerIsStacked: false,
                                                         outerDirectionClockwise: .random(),
                                                         innerDirectionClockwise: .random(),
                                                         spaceAfter: 25,
                                                          acceleration: acceleration),
                                  .solidRing(segmentsCount: 4,
                                             rotationSpeed: .medium,
                                             directionClockwise: .random(),
                                             isStacked: false,
                                             spaceAfter: 100,
                                             acceleration: acceleration)].randomElement()!)
                
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.doubleRing(outerSegmentsCount: 8,
                                                        innerSegmentsCount: 4,
                                                        outerRotationSpeed: .slow,
                                                        innerRotationSpeed: .medium,
                                                        outerIsStacked: false,
                                                        innerIsStacked: false,
                                                        outerDirectionClockwise: .random(),
                                                        innerDirectionClockwise: .random(),
                                                        spaceAfter:25,
                                                        acceleration: acceleration),
                                            .solidRing(segmentsCount: 4,
                                                       rotationSpeed: .medium,
                                                       directionClockwise: .random(),
                                                       isStacked: false,
                                                       spaceAfter: 100,
                                                       acceleration: acceleration)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func bossLevel() -> Level {
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
                     isBoss: true,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
}

