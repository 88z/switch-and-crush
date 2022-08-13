//
//  GamePresented.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class DefaultPresenter: BasePresenter {
    
    let startState: State
    private weak var gameOverUI: UIScene?
    
    
    init(vc: GameViewController, startState: State) {
        self.startState = startState
        super.init(vc: vc)
    }
    
    required init(vc: GameViewController) {
        fatalError("init(vc:) has not been implemented")
    }
    
    override func present(){
        super.present()
        startGame()
    }
    
    
    override func crashed() {

    }
    
    override func didFinish(level:Level) {
        
    }
    
    private func startGame () {
        vc?.hideUI()
        let levelFactory = LevelFactory()
        battleFieldScene?.start(level: levelFactory.level0())
    }
    
    override func uiScenePressed(scene: UIScene) {
        if scene == gameOverUI {
            return
        }
        startGame()
    }
    
    override func uiSceneElementPressed(scene: UIScene, element: UISceneElement) {
        guard  scene == gameOverUI,
        let heroState = battleFieldScene.heroState,
        let vc = vc else {
            return
        }

        vc.freezeInteraction()
        let newPresenter = DefaultPresenter(vc: vc, startState: heroState)
        vc.set(presenter:newPresenter)
    }
    
    override func crashAnimationFinished(scene: BattleFieldScene) {
        super.crashAnimationFinished(scene: scene)
        showGameOver()
    }
    
    func showGameOver() {
        let frame = vc?.view.frame ?? .zero
        let gameOverUI = UIScene(size: UIScreen.main.bounds.size, elements:[
            UISceneText(position: CGPoint(x: frame.midX, y: frame.maxY-UI_TITLE_TOP_OFFSET), color: .text(), delayBeforePresent: 0, text: "Game Over".localiz()),
            UISceneButton(position: CGPoint(x: frame.midX, y: frame.minY+UI_BUTTON_BOTTOM_OFFSET), color: .text(), delayBeforePresent: 1, text: "play again".localiz())
        ])
        gameOverUI.uiSceneDelegate = self
        vc?.showUI(scene: gameOverUI)
        self.gameOverUI = gameOverUI
    }
}
