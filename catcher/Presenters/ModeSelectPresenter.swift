//
//  ModeSelectPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.11.2022.
//

import Foundation
import SpriteKit

class ModeSelectPresenter: Presenter, TrivialUISceneDelegate {
    public weak var vc: GameViewController?
    let progress: Progress
    
    private let infiniteButtonName = "infinite"
    private let aracadeButtonName = "arcade"
    
    func present() {
        let frame = vc?.view.frame ?? .zero
        let ui = TrivialUIScene(size: UIScreen.main.bounds.size, elements:[
            TrivialUISceneButton(position: CGPoint(x: frame.midX, y: frame.minY+UI_BUTTON_BOTTOM_OFFSET), color: .text(), delayBeforePresent: 1, text: "INFINITE".localiz(), name:infiniteButtonName),
            TrivialUISceneButton(position: CGPoint(x: frame.midX, y: frame.minY+UI_BUTTON_BOTTOM_OFFSET+UI_VERTICAL_SPACE_BETWEEN_BUTTONS), color: .text(), delayBeforePresent: 1, text: "ARCADE".localiz(), name:aracadeButtonName),

        ])
        ui.uiSceneDelegate = self
        vc?.show(uiScene: ui)
    }
    
    func uiScenePressed(scene: TrivialUIScene) {
        
    }
    
    func uiSceneElementPressed(scene: TrivialUIScene, element: TrivialUISceneElement) {
        guard let vc = vc else {
            assertionFailure("viewController no found")
            return
        }
        if element.name == infiniteButtonName {
            InfiniteStartPresenter(vc: vc).present()
        } else if element.name == aracadeButtonName {
            LevelSelectPresenter(vc: vc, progress: progress).present()
        }
    }
    
    init(vc: GameViewController, progress: Progress) {
        self.vc = vc
        self.progress = progress
    }
    
}
