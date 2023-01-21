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
    private let indexStr: String
    init(vc: GameViewController,
         progress: Progress,
         level: Level) {
        self.vc = vc
        self.progress = progress
        self.level = level
        if let index = progress.index(of: level) {
            indexStr = String(index+1)
        } else {
            indexStr = ""
        }
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
                LevelSelectPresenter(vc: vc, progress: self.progress).present()
                vc.freezeInteraction()
            }))
        }
        let levelFinishView = TitleButtonsView(frame: .zero,
                                               buttonModels: buttonModels,
                                               title: "levEl \(indexStr) Finished",
                                               topText: nil,
                                               imageName: "happyFace",
                                               backButtonIcon: .home,
                                               backButtonAction: {
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
