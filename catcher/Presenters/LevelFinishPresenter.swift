//
//  LevelFinishPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.11.2022.
//

import Foundation
import SpriteKit

class LevelFinishPresenter: Presenter {
    public weak var vc: GameViewController?
    private let progress: Progress
    private let level: Level
    init(vc: GameViewController,
         progress: Progress,
         level: Level) {
        self.vc = vc
        self.progress = progress
        self.level = level
    }
    func present() {
        var buttonModels: [ButtonViewModel] = []
        let nextLevel = progress.levelAfter(level)
        if nextLevel != nil {
            buttonModels.append(ButtonViewModel(text: "nexT lEvel".localiz(), action: {
                guard let vc = self.vc else {
                    assertionFailure("viewController no found")
                    return
                }
                vc.freezeInteraction()
                GamePresenter(vc: vc, startState: .first, level: nextLevel!, progress: self.progress, gameMode: .arcade).present()
            }))
        }
        let levelFinishView = TitleButtonsView(frame: .zero, buttonModels: buttonModels, title: "levEl Finished", topText: nil, backButtonIcon: .home, backButtonAction: {
            guard let vc = self.vc else {
                assertionFailure("viewController no found")
                return
            }
            vc.freezeInteraction()
            ModeSelectPresenter(vc: vc, progress: self.progress).present()
        })
        vc?.show(uiView: levelFinishView)
    }
}
