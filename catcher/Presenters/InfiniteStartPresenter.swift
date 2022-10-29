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
            GamePresenter(vc: vc, startState: .first, level: levelFactory.infiniteLevel(), progress: Progress(levelFactory: levelFactory)).present()
        }
    }
    
    public weak var vc: GameViewController?
    
    init(vc: GameViewController) {
        self.vc = vc
    }
    
    func present() {
        let frame = vc?.view.frame ?? .zero
        let ui = TrivialUIScene(size: UIScreen.main.bounds.size, elements:[
            TrivialUISceneButton(position: CGPoint(x: frame.midX, y: frame.midY), color: .text(), delayBeforePresent: 1, text: "Start".localiz())
        ])
        ui.uiSceneDelegate = self
        vc?.show(uiScene: ui)
    }
    
}
