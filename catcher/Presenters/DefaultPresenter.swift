//
//  GamePresented.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class DefaultPresenter: BasePresenter {
    
    let showIntro: Bool
    let startState: State
    init(vc: GameViewController, showIntro: Bool, startState: State) {
        self.showIntro = showIntro
        self.startState = startState
        super.init(vc: vc)
    }
    
    required init(vc: GameViewController) {
        fatalError("init(vc:) has not been implemented")
    }
    
    override func present(){
        super.present()
        if showIntro {
            let menuScene = OneActionScene(size: UIScreen.main.bounds.size, elements:[])
            menuScene.oneActionSceneDelegate = self
            vc?.showUI(scene: menuScene)
        } else {
            startGame()
        }
       
    }
    
    
    override func crashed() {
//        guard let vc = vc else {
//            return
//        }
//        vc.freezeInteraction()
//        let newPresenter = DefaultPresenter(vc: vc, showIntro: true, startState: battleFieldScene.heroState)
//        vc.set(presenter:newPresenter)
    }
    
    override func didFinish(level:Level) {
        
    }
    
    private func startGame () {
        vc?.hideUI()
        battleFieldScene?.start(level: Level(obstacleCount: 20, initialSpeed: 200, acceleration: 10, name:"default", initialState: startState, userInterationEnabled: true))
    }
    
    override func oneActionScenePressed(scene: OneActionScene) {
        startGame()
    }
}
