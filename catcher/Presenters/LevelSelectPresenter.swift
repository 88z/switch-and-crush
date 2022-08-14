//
//  LevelSelectPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import SpriteKit

class LevelSelectPresenter: Presenter {
    public weak var vc: GameViewController?
    let progress: ArcadeProgress
    
    init(vc: GameViewController, progress: ArcadeProgress) {
        self.progress = progress
        self.vc = vc
    }

    
    func present() {
        vc?.show(uiView: LevelSelectView(frame: .zero))
    }
}
