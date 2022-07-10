//
//  OnboardingPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class OnboardingPresenter: BasePresenter {
    private weak var switchColorUI: UIScene?
    private weak var redObstacleUI: UIScene?
    private weak var blueObstacleUI: UIScene?
    
    override func present(){
        super.present()
        let frame = vc?.view.frame ?? .zero
        
        let thisIsBallUI = UIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
            UISceneText(position: CGPoint(x: frame.midX - 40, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "This is BALL".localiz()),
            UISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 1, text: "Tap to switch BALL color".localiz()),
            
        ])
        thisIsBallUI.uiSceneDelegate = self
        vc?.showUI(scene: thisIsBallUI)
        self.switchColorUI = thisIsBallUI
    }
    
    override func uiScenePressed(scene: UIScene) {
        if scene == switchColorUI {
            vc?.hideUI()
            battleFieldScene?.start(level: Level(obstacleCount: 1, initialSpeed: 200, acceleration: 0.00, name:"1", initialState: State.second, userInterationEnabled: false), shouldShowCounter: false)
            let frame = vc?.view.frame ?? .zero
            let redObstacleUI = UIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
                UISceneText(position: CGPoint(x: frame.midX, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "red BALL crashes red blocks".localiz()),
                UISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 3, text: "switch BALL color now".localiz())
            ])
            redObstacleUI.uiSceneDelegate = self
            vc?.showUI(scene: redObstacleUI)
            self.redObstacleUI = redObstacleUI
        } else if scene == redObstacleUI {
            vc?.hideUI()
            battleFieldScene?.start(level: Level(obstacleCount: 1, initialSpeed: 200, acceleration: 0.00, name:"1", initialState: State.first, userInterationEnabled: false), shouldShowCounter: false)
            let frame = vc?.view.frame ?? .zero
            let blueObstacleUI = UIScene(size: UIScreen.main.bounds.size, uifreezeTime: 3, elements:[
                UISceneText(position: CGPoint(x: frame.midX, y: frame.maxY - heroTopOffset+100), delayBeforePresent: 0, text: "blue BALL crashes blue blocks".localiz()),
                UISceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 3, text: "switch BALL color to start the game".localiz())
            ])
            blueObstacleUI.uiSceneDelegate = self
            vc?.showUI(scene: blueObstacleUI)
            self.blueObstacleUI = redObstacleUI
        } else {
            vc?.hideUI()
            guard let vc = vc else {
                return
            }
            let newPresenter = DefaultPresenter(vc: vc, showIntro: false, startState: State.second)
            vc.set(presenter:newPresenter)
        }
    }
}
