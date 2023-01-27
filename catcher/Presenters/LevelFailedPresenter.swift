//
//  GameOverPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 07.11.2022.
//

import Foundation
import SpriteKit

class LevelFailedPresenter:Presenter {
    public weak var vc: GameViewController?
    private let title: String
    private let topText: String?
    private let level: Level
    private let progress: Progress
    private let gameMode: GameMode
    
    init(vc: GameViewController,
         level:Level,
         progress: Progress,
         gameMode: GameMode,
         score: Int) {
        self.vc = vc
        self.level = level
        self.progress = progress
        self.gameMode = gameMode
        
        let indexStr: String
        if let index = progress.index(of: level) {
            indexStr = String(index+1)
        } else {
            indexStr = ""
        }
        
        if gameMode == .arcade {
            self.title = "levEl \(indexStr) Failed"
        } else {
            self.title = "score: \(score)\nbest: \(progress.infiniteModeRecord)"
        }
        topText =  gameMode == .arcade ? "\(score) / \(level.capacity)" : nil
    }
    
    func present() {
        let gameOverView = TitleButtonsView(frame: .zero,
                                            buttonModels: [
            ButtonViewModel(text: "try again".localiz(), action: {
                guard let vc = self.vc else {
                    assertionFailure("viewController no found")
                    return 
                }
                vc.freezeInteraction()
                GamePresenter(vc: vc, startState: .first, level: self.level, progress: self.progress, gameMode: self.gameMode).present()
            }),
        ], title: title, topText: topText, imageName: "deadFace", backButtonIcon: .home, backButtonAction: {
            guard let vc = self.vc else {
                assertionFailure("viewController no found")
                return
            }
            vc.freezeInteraction()
            LevelSelectPresenter(vc: vc, progress: self.progress).present()
        })
        vc?.show(uiView: gameOverView)
        
    }
    
    
}
