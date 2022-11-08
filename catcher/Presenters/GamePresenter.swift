//
//  GamePresented.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class GamePresenter: BattleFieldPresenter {
    
    let startState: State
    private weak var gameOverUI: TrivialUIScene?
    let level: Level
    let progress: Progress
    let gameMode: GameMode
    
    
    init(vc: GameViewController, startState: State, level: Level, progress: Progress, gameMode: GameMode) {
        self.startState = startState
        self.level = level
        self.progress = progress
        self.gameMode = gameMode
        super.init(vc: vc)
    }
    
    override init(vc: GameViewController) {
        fatalError("init(vc:) has not been implemented")
    }
    
    override func present(){
        super.present()
        startGame()
    }
    
    
    override func crashed() {

    }
    
    override func didFinish(level:Level) {
        //TODO didFinishPresenter
    }
    
    private func startGame () {
        vc?.hideUI()
        battleFieldScene?.start(level: level, shouldPlaceHero: true, mode: self.gameMode)
    }
    
    override func uiScenePressed(scene: TrivialUIScene) {
        if scene == gameOverUI {
            return
        }
        startGame()
    }
    
    override func uiSceneElementPressed(scene: TrivialUIScene, element: TrivialUISceneElement) {
        guard  scene == gameOverUI,
        let heroState = battleFieldScene.heroState,
        let vc = vc else {
            return
        }

        vc.freezeInteraction()
        let newPresenter = GamePresenter(vc: vc, startState: heroState, level: level, progress: progress, gameMode: gameMode)
        newPresenter.present()
    }
    
    override func crashAnimationFinished(scene: BattleFieldScene) {
        super.crashAnimationFinished(scene: scene)
        //TODO разный гейм овер для разных режимов игры
        guard let vc = self.vc else {
            assertionFailure("viewController no found")
            return
        }
        GameOverPresenter(vc: vc, level: level, progress: progress, gameMode: self.gameMode, score: scene.getProgress()).present()
        battleFieldScene.isDimmed = true
        
    }
}
