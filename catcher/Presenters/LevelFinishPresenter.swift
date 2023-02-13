//
//  LevelFinishPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 09.11.2022.
//

import Foundation
import SpriteKit
import Amplitude
import StoreKit

class LevelFinishPresenter: Presenter {
    public weak var vc: GameViewController?
    private let progress: Progress
    private let level: Level
    private let indexStr: String
    private let index: Int?
    init(vc: GameViewController,
         progress: Progress,
         level: Level) {
        self.vc = vc
        self.progress = progress
        self.level = level
        if let index = progress.index(of: level) {
            indexStr = String(index+1)
            self.index = index
        } else {
            indexStr = ""
            self.index = nil
        }
        
    }
    func present() {
        Amplitude.instance().logEvent("LevelFinished_Opened",
                                      withEventProperties: ["level_index": self.index ?? "",
                                                            "level_name": self.level.name])
        var buttonModels: [ButtonViewModel] = []
        let nextLevel = progress.levelAfter(level)
        if nextLevel != nil {
            buttonModels.append(ButtonViewModel(text: "nexT lEvel".localiz(), action: {
                Amplitude.instance().logEvent("LevelFinished_NextLevel_Taped",
                                              withEventProperties: ["level_index": self.index ?? "",
                                                                    "level_name": self.level.name,
                                                                    "is_endless": self.level.isEndless])
                guard let vc = self.vc else {
                    assertionFailure("viewController no found")
                    return
                }
                LevelSelectPresenter(vc: vc, progress: self.progress).present()
                if self.index ?? 0 >= 7 {
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            }))
        }
        let levelFinishView = TitleButtonsView(frame: .zero,
                                               buttonModels: buttonModels,
                                               title: "levEl \(indexStr) Finished",
                                               topText: nil,
                                               imageName: "happyFace",
                                               backButtonIcon: nil,
                                               backButtonAction: nil)
        vc?.show(uiView: levelFinishView)
    }
}
