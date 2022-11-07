//
//  ModeSelectPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.11.2022.
//

import Foundation
import SpriteKit

class ModeSelectPresenter: Presenter {
    public weak var vc: GameViewController?
    let progress: Progress
    
    private let infiniteButtonName = "infinite"
    private let aracadeButtonName = "arcade"
    
    func present() {
        let modeSelectView = TitleButtonsView(frame: .zero,
                                              buttonModels: [
                                                ButtonViewModel(text: "arCade mOde", action: {
                                                    guard let vc = self.vc else {
                                                        assertionFailure("viewController no found")
                                                        return
                                                    }
                                                    LevelSelectPresenter(vc: vc, progress: self.progress).present()
                                                }),
                                                ButtonViewModel(text: "Endless mOde", action: {
                                                    guard let vc = self.vc else {
                                                        assertionFailure("viewController no found")
                                                        return
                                                    }
                                                    InfiniteStartPresenter(vc: vc).present()
                                                }),
                                              ],
                                              title: nil,
                                              backButtonAction: nil)
        vc?.show(uiView: modeSelectView)
    }
    
    init(vc: GameViewController, progress: Progress) {
        self.vc = vc
        self.progress = progress
    }
    
}
