//
//  GameOverPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 07.11.2022.
//

import Foundation
import SpriteKit

class GameOverPresenter:Presenter {
    public weak var vc: GameViewController?
    private let title: String
    private let level: Level
    private let progress: Progress
    
    init(vc: GameViewController, title: String, level:Level, progress: Progress) {
        self.vc = vc
        self.title = title
        self.level = level
        self.progress = progress
    }
    func present() {
        let gameOverView = TitleButtonsView(frame: .zero, buttonModels: [
            ButtonViewModel(text: "try again".localiz(), action: {
                guard let vc = self.vc else {
                    assertionFailure("viewController no found")
                    return 
                }
                vc.freezeInteraction()
                GamePresenter(vc: vc, startState: .first, level: self.level, progress: self.progress).present()
            })
            
        ], title: title, backButtonAction: nil)
        vc?.show(uiView: gameOverView)
        
    }
    
    
}
