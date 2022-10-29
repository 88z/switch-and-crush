//
//  OnboardingPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class OnboardingPresenter: BattleFieldPresenter {
    private weak var switchColorUI: TrivialUIScene?
    private weak var redObstacleUI: TrivialUIScene?
    private weak var blueObstacleUI: TrivialUIScene?
    
    let progress: ArcadeProgress
    
    init(vc: GameViewController, progress: ArcadeProgress) {
        self.progress = progress
        super.init(vc: vc)
    }
    
    override func present(){
        super.present()
        let frame = vc?.view.frame ?? .zero
        
        let thisIsBallUI = TrivialUIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
            TrivialUISceneText(position: CGPoint(x: frame.midX - 40, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "This is BALL".localiz()),
            TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 1, text: "Tap to switch BALL color".localiz()),
            
        ])
        battleFieldScene?.start(level: Level(initialObstacleTypes: [],
                                             obstacleTypesForTail: [],
                                             capacity: 100,
                                             initialSpeed: 200,
                                             acceleration: 0.00,
                                             name:"1",
                                             initialState: State.first,
                                             userInterationEnabled: false,
                                             colorScheme: .defaultScheme()),
                                shouldShowCounter: false,
                                shouldPlaceHero: true)
        thisIsBallUI.uiSceneDelegate = self
        vc?.show(uiScene: thisIsBallUI)
        self.switchColorUI = thisIsBallUI
    }
    
    override func uiScenePressed(scene: TrivialUIScene) {
        if scene == switchColorUI {
            vc?.hideUI()
            battleFieldScene?.start(level: Level(initialObstacleTypes: [.plank(blinkInterval: 0)],
                                                 obstacleTypesForTail: [],
                                                 capacity: 1,
                                                 initialSpeed: 200,
                                                 acceleration: 0.00,
                                                 name:"1",
                                                 initialState: State.second,
                                                 userInterationEnabled: false,
                                                 colorScheme: .defaultScheme()),
                                    shouldShowCounter: false,
                                    shouldPlaceHero: true)
            let frame = vc?.view.frame ?? .zero
            let redObstacleUI = TrivialUIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
                TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "red BALL crashes red blocks".localiz()),
                TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 3, text: "switch BALL color now".localiz())
            ])
            redObstacleUI.uiSceneDelegate = self
            vc?.show(uiScene: redObstacleUI)
            self.redObstacleUI = redObstacleUI
        } else if scene == redObstacleUI {
            vc?.hideUI()
            battleFieldScene?.start(level: Level(initialObstacleTypes: [.plank(blinkInterval: 0)],
                                                 obstacleTypesForTail: [],
                                                 capacity: 1,
                                                 initialSpeed: 200, acceleration: 0.00, name:"1", initialState: State.first, userInterationEnabled: false, colorScheme: .defaultScheme()), shouldShowCounter: false,shouldPlaceHero: true)
            let frame = vc?.view.frame ?? .zero
            let blueObstacleUI = TrivialUIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
                TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "blue BALL crashes blue blocks".localiz()),
                TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 3, text: "switch BALL color to start the game".localiz())
            ])
            blueObstacleUI.uiSceneDelegate = self
            vc?.show(uiScene: blueObstacleUI)
            self.blueObstacleUI = redObstacleUI
        } else {
            vc?.hideUI()
            guard let vc = vc else {
                return
            }
            progress.isOnboardingShown = true
            guard let level = progress.levels.first else {
                return
            }
            let newPresenter = GamePresenter(vc: vc, startState: State.second, level: level, progress: progress)
            newPresenter.present()
        }
    }
}
