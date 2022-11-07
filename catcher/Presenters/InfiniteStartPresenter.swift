//
//  InfiniteStartPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 29.10.2022.
//

import Foundation
import SpriteKit

class InfiniteStartPresenter: Presenter, TrivialUISceneDelegate {
    
    func uiScenePressed(scene: TrivialUIScene) {
        
    }
    
    func uiSceneElementPressed(scene: TrivialUIScene, element: TrivialUISceneElement) {
        let levelFactory = LevelFactory()
        guard let vc = vc else {
            assertionFailure("viewController not found")
            return
        }
        if element is TrivialUISceneButton {
            GamePresenter(vc: vc, startState: .first, level: levelFactory.infiniteLevel(), progress: progress).present()
        }
    }
    
    public weak var vc: GameViewController?
    private let progress = Progress(levelFactory: LevelFactory())
    init(vc: GameViewController) {
        self.vc = vc
    }
    
    func present() {
        let infiniteStartView = TitleButtonsView(frame: .zero, buttonModels: [
            ButtonViewModel(text: "Start", action: {
                guard let vc = self.vc else {
                    assertionFailure("viewController not found")
                    return
                }
                GamePresenter(vc: vc, startState: .first, level: LevelFactory().infiniteLevel(), progress: self.progress).present()
            })
            ], title: "best score: \(progress.infiniteModeRecord)") {
            guard let vc = self.vc else {
                return
            }
            ModeSelectPresenter(vc:vc, progress: self.progress).present()
        }
        vc?.show(uiView: infiniteStartView)
    }
    
    
}
