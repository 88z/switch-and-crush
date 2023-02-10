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
        let acceleration: CGFloat = 1
        
        let plankSpaceAfter: () -> CGFloat = { CGFloat(randomBetween(100, and: 150)) }
        let solidRingSpaceAfter: () -> CGFloat = { CGFloat(randomBetween(25, and: 75)) }
        let fragmentedRingSpaceAfter: () -> CGFloat = { CGFloat(randomBetween(100, and: 150)) }
        
        for _ in 0..<10{
            obstacleTypes.append([
                .plank(state: State.random(),
                       blinkInterval: 0,
                       spaceAfter: plankSpaceAfter(),
                       acceleration: acceleration),
                .plank(state: State.random(),
                       blinkInterval: 0,
                       spaceAfter: plankSpaceAfter(),
                       acceleration: acceleration),
                .solidRing(segmentsCount: 4,
                           rotationSpeed: .medium,
                           directionClockwise: .random(),
                           isStacked: false,
                           spaceAfter: solidRingSpaceAfter(),
                           acceleration: acceleration),
                .solidRing(segmentsCount: 4,
                           rotationSpeed: .medium,
                           directionClockwise: .random(),
                           isStacked: false,
                           spaceAfter: solidRingSpaceAfter(),
                           acceleration: acceleration),
                .pingPongPlank(swingSpeed: .fast,
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter:plankSpaceAfter(),
                               acceleration: acceleration),
                .pingPongPlank(swingSpeed: .fast,
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter:plankSpaceAfter(),
                               acceleration: acceleration),
                .carouselPlank(partsCount: 4,
                               carouselSpeed: .fast,
                               directionRight: .random(),
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter: plankSpaceAfter(),
                               acceleration: acceleration),
                .carouselPlank(partsCount: 6,
                               carouselSpeed: .medium,
                               directionRight: .random(),
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter: plankSpaceAfter(),
                               acceleration: acceleration),
                .pendulumPlank(partsCount: 2,
                               swingSpeed: .fast,
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter: plankSpaceAfter(),
                               acceleration: acceleration),
                .pendulumPlank(partsCount: 2,
                               swingSpeed: .fast,
                               isStacked: false,
                               blinkInterval: 0,
                               spaceAfter: plankSpaceAfter(),
                               acceleration: acceleration),
                .fragmentedRing(segmentsCount: 4,
                                rotationSpeed: .medium,
                                directionClockwise: true,
                                isStacked: false,
                                spaceAfter: fragmentedRingSpaceAfter(),
                                acceleration: acceleration),
                .gatePlank(swingSpeed: .medium,
                           isStacked: false,
                           blinkInterval: 0,
                           spaceAfter: plankSpaceAfter(),
                           acceleration: acceleration),
                .ringWithBrick(segmentsCount: 4,
                           rotationSpeed: .medium,
                               directionClockwise: .random(),
                           isStacked: false,
                           spaceAfter: solidRingSpaceAfter(),
                           acceleration: acceleration),
                .doubleRing(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: .random(),
                            innerDirectionClockwise: .random(),
                            spaceAfter: solidRingSpaceAfter(),
                            acceleration: acceleration),
                .doubleRingWithBrick(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: .random(),
                            innerDirectionClockwise: .random(),
                            spaceAfter: solidRingSpaceAfter(),
                            acceleration: acceleration),
                .fragmentedRingWithBrick(segmentsCount: 4,
                                         rotationSpeed: .medium,
                                         directionClockwise: .random(),
                                         isStacked: false,
                                         spaceAfter: fragmentedRingSpaceAfter(),
                                         acceleration: acceleration),
                .fragmentedDoubleRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: .random(),
                                               innerDirectionClockwise: .random(),
                                               spaceAfter: fragmentedRingSpaceAfter(),
                                               acceleration: acceleration),
                .fragmentedRingSolidRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: .random(),
                                               innerDirectionClockwise: .random(),
                                               spaceAfter: fragmentedRingSpaceAfter(),
                                               acceleration: acceleration),
                .solidRingFragmentedRing(outerSegmentsCount: 8,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: .random(),
                                               innerDirectionClockwise: .random(),
                                               spaceAfter: solidRingSpaceAfter(),
                                               acceleration: acceleration),
                .fragmentedRingSolidRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: .random(),
                                               innerDirectionClockwise: .random(),
                                               spaceAfter: fragmentedRingSpaceAfter(),
                                               acceleration: acceleration),
                .solidRingFragmentedRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: .random(),
                                               innerDirectionClockwise: .random(),
                                               spaceAfter: solidRingSpaceAfter(),
                                               acceleration: acceleration),

            ].randomElement()! )
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: obstacleTypes,
                     capacity: -1,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func level1() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 25
        for _ in 0..<15 {
            obstacleTypes.append(.plank(state: .random(), blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.plank(state: .first, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0), .plank(state: .second, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(150, and: 200)), acceleration: 0)],
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
        let acceleration: CGFloat = 25

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
                     colorScheme: .enigma)
    }
    
    func level3() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 10
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
                     colorScheme: .blueRed)
    }
    
    func pendulumLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 10
        
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 13
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
                     colorScheme: .blueRed)
    }
    
    func  level6() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 8
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
                     colorScheme: .blueRed)
    }
    
    func level8() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 10
        let spaceShrink = 5
        let capacity = 10
        for i in 0..<capacity {
            obstacleTypes.append(.carouselPlank(partsCount: 6,
                                                carouselSpeed: .medium,
                                                directionRight: Bool.random(),
                                                isStacked: false,
                                                blinkInterval: 0,
                                                spaceAfter: CGFloat(randomBetween(150, and: 200) - i*spaceShrink),
                                                acceleration: acceleration))
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.carouselPlank(partsCount: 6, carouselSpeed: .medium, directionRight: true, isStacked: false, blinkInterval: 0, spaceAfter: CGFloat(randomBetween(100, and: 150)), acceleration: 0)],
                     capacity: capacity,
                     initialSpeed: 200,
                     name:#function,
                     isBoss: false,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
    func bigRandomLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 3
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
                     colorScheme: .india)
    }
    
    func plankAndCarouselLevel() -> Level{
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 4
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
        let acceleration: CGFloat = 5
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
                     colorScheme: .blueRed)
    }
    
    func pingPongLevel() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 15
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
                     colorScheme: .darkorangeCornflower)
    }
    
    func level12() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 15
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
        let acceleration: CGFloat = 15
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 0
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 5
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
                     colorScheme: .deepBlueDarkGrey)
    }
    
    func level20() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 7
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
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 5
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
                     colorScheme: .lava)
    }
    
    func level26() -> Level {
        var obstacleTypes:[ObstacleType] = []
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 5
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
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 10
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
        let acceleration: CGFloat = 1.75
        let capacity = 50
        for _ in 0..<capacity {
            let direction = Bool.random()
            obstacleTypes.append([
                .solidRing(segmentsCount: 4,
                           rotationSpeed: .fast,
                           directionClockwise: direction,
                           isStacked: false,
                           spaceAfter: CGFloat(randomBetween(50, and: 100)),
                           acceleration: acceleration),
                .ringWithBrick(segmentsCount: 4,
                           rotationSpeed: .medium,
                           directionClockwise: direction,
                           isStacked: false,
                           spaceAfter: CGFloat(randomBetween(50, and: 100)),
                           acceleration: acceleration),
                .doubleRing(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: direction,
                            innerDirectionClockwise: !direction,
                            spaceAfter: CGFloat(randomBetween(50, and: 100)),
                            acceleration: acceleration),
                .doubleRing(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: direction,
                            innerDirectionClockwise: direction,
                            spaceAfter: CGFloat(randomBetween(50, and: 100)),
                            acceleration: acceleration),
                .doubleRingWithBrick(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: direction,
                            innerDirectionClockwise: direction,
                            spaceAfter: CGFloat(randomBetween(50, and: 100)),
                            acceleration: acceleration),
                .doubleRingWithBrick(outerSegmentsCount: 8,
                            innerSegmentsCount: 4,
                            outerRotationSpeed: .medium,
                            innerRotationSpeed: .medium,
                            outerIsStacked: false,
                            innerIsStacked: false,
                            outerDirectionClockwise: direction,
                            innerDirectionClockwise: !direction,
                            spaceAfter: CGFloat(randomBetween(50, and: 100)),
                            acceleration: acceleration),
                .fragmentedRingWithBrick(segmentsCount: 4,
                                         rotationSpeed: .medium,
                                         directionClockwise: .random(),
                                         isStacked: false,
                                         spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                         acceleration: acceleration),
                .fragmentedDoubleRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .fragmentedDoubleRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: !direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .fragmentedRingSolidRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .fragmentedRingSolidRing(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: !direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .solidRingFragmentedRing(outerSegmentsCount: 8,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .solidRingFragmentedRing(outerSegmentsCount: 8,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: !direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .fragmentedRingSolidRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .fragmentedRingSolidRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: !direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .solidRingFragmentedRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                               acceleration: acceleration),
                .solidRingFragmentedRingWithBrick(outerSegmentsCount: 6,
                                               innerSegmentsCount: 4,
                                               outerRotationSpeed: .medium,
                                               innerRotationSpeed: .medium,
                                               outerIsStacked: false,
                                               innerIsStacked: false,
                                               outerDirectionClockwise: !direction,
                                               innerDirectionClockwise: direction,
                                               spaceAfter: CGFloat(randomBetween(100, and: 150)),
                                               acceleration: acceleration),
                .carouselPlank(partsCount: 6,
                                carouselSpeed: .fast,
                                directionRight: Bool.random(),
                                isStacked: false,
                                blinkInterval: 0,
                                spaceAfter: CGFloat(randomBetween(150, and: 200)),
                                acceleration: acceleration)
                
                
            ].randomElement()!)
        }
        return Level(initialObstacleTypes: obstacleTypes,
                     obstacleTypesForTail: [.solidRing(segmentsCount: 4,
                                                       rotationSpeed: .medium,
                                                       directionClockwise: .random(),
                                                       isStacked: false,
                                                       spaceAfter: CGFloat(randomBetween(50, and: 100)),
                                                       acceleration: acceleration)],
                     capacity: capacity,
                     initialSpeed: 175,
                     name:#function,
                     isBoss: true,
                     initialState: .first,
                     userInterationEnabled: true,
                     colorScheme: .blueRed)
    }
    
}

