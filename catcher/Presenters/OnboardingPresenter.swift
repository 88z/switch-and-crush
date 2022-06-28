//
//  OnboardingPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class OnboardingPresenter: BasePresenter {
    
    private weak var thisIsBallUI: OneActionScene?
    private weak var secondStepUI: OneActionScene?
    
    override func present(){
        super.present()
        let frame = vc?.view.frame ?? .zero
        
        let thisIsBallUI = OneActionScene(size: UIScreen.main.bounds.size, elements:[
            OneActionSceneText(position: CGPoint(x: frame.midX - 40, y: frame.maxY - heroTopOffset-150), delayBeforePresent: 1, text: "This is BALL"),
            OneActionSceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 3, text: "Tap the screen to continue"),
            
        ])
        thisIsBallUI.oneActionSceneDelegate = self
        vc?.showUI(scene: thisIsBallUI)
        self.thisIsBallUI = thisIsBallUI
    }
    
    override func oneActionScenePressed(scene: OneActionScene) {
        if scene == thisIsBallUI {
            vc?.hideUI()
            battleFieldScene?.start(level: Level(obstacleCount: 1, initialSpeed: 100, acceleration: 0.00, name:"1", initialState: State.first, userInterationEnabled: false))
        } else if scene == secondStepUI {
            vc?.hideUI()
            guard let vc = vc else {
                return
            }
            let newPresenter = DefaultPresenter(vc: vc, showIntro: false, startState: State.second)
            vc.set(presenter:newPresenter)
        }
    }
    
    override func didFinish(level:Level) {
        if level.name == "1" {
            let frame = vc?.view.frame ?? .zero
            let secondStepUI = OneActionScene(size: UIScreen.main.bounds.size, elements:[
                OneActionSceneText(position: CGPoint(x: frame.midX, y: frame.minY + 200), delayBeforePresent: 0, text: "To switch BALL color tap the screen ")
            ])
            secondStepUI.oneActionSceneDelegate = self
            vc?.showUI(scene: secondStepUI)
            self.secondStepUI = secondStepUI
        } 
    }
}
