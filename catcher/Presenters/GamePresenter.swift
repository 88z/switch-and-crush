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
    
    
    init(vc: GameViewController, startState: State, level: Level, progress: Progress) {
        self.startState = startState
        self.level = level
        self.progress = progress
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
        battleFieldScene?.start(level: level, shouldPlaceHero: true)
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
        let newPresenter = GamePresenter(vc: vc, startState: heroState, level: level, progress: progress)
        newPresenter.present()
    }
    
    override func crashAnimationFinished(scene: BattleFieldScene) {
        super.crashAnimationFinished(scene: scene)
        //TODO разный гейм овер для разных режимов игры
        guard let vc = self.vc else {
            assertionFailure("viewController no found")
            return
        }
        GameOverPresenter(vc: vc, title: "game over", level: level, progress: progress).present()
        
        
//        showGameOver(score: scene.getProgress())
    }
    
    //TODO вынести в gameover presenter
    func showGameOver(score: Int) {
        let frame = vc?.view.frame ?? .zero
        
        var elements: [TrivialUISceneElement] = []
        if score <= progress.infiniteModeRecord {
            elements.append(contentsOf:
                                [TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.maxY-UI_TITLE_TOP_OFFSET), color: .text(), delayBeforePresent: 0, text: "score: \(score)".localiz()),
                                 TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.maxY-UI_TITLE_TOP_OFFSET-40), color: .text(), delayBeforePresent: 0.5, text: "best: \(progress.infiniteModeRecord)".localiz())
                                ])
        } else {
            progress.infiniteModeRecord = score
            elements.append(contentsOf:
                                [TrivialUISceneText(position: CGPoint(x: frame.midX, y: frame.maxY-UI_TITLE_TOP_OFFSET), color: .text(), delayBeforePresent: 0, text: "new record: \(score)".localiz())
                                ])
        }
        elements.append(TrivialUISceneButton(position: CGPoint(x: frame.midX, y: frame.minY+UI_BUTTON_BOTTOM_OFFSET), color: .text(), delayBeforePresent: 1, text: "play again".localiz(), name: "over"))
        
        let gameOverUI = TrivialUIScene(size: UIScreen.main.bounds.size, elements:elements)
        gameOverUI.uiSceneDelegate = self
        battleFieldScene.isDimmed = true
        vc?.show(uiScene: gameOverUI)
        self.gameOverUI = gameOverUI
    }
}
