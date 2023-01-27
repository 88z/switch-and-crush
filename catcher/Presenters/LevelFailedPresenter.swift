//
//  GameOverPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 07.11.2022.
//

import Foundation
import SpriteKit
import Amplitude

class LevelFailedPresenter:Presenter {
    public weak var vc: GameViewController?
    private let title: String
    private let topText: String?
    private let level: Level
    private let progress: Progress
    private let index: Int?
    private let score:Int
    
    init(vc: GameViewController,
         level:Level,
         progress: Progress,
         score: Int) {
        self.vc = vc
        self.level = level
        self.progress = progress
        self.score = score
        
        let indexStr: String
        if let index = progress.index(of: level) {
            indexStr = String(index+1)
            self.index = index
        } else {
            indexStr = ""
            self.index = nil
        }
        
        if level.isEndless {
            self.title = "score: \(score)\nbest: \(progress.infiniteModeRecord)"
        } else {
            self.title = "levEl \(indexStr) Failed"
        }
        topText =  level.isEndless ? nil : "\(score) / \(level.capacity)"
    }
    
    func present() {
        Amplitude.instance().logEvent("LevelFailed_Opened",
                                      withEventProperties: ["level_index": self.index ?? "",
                                                            "level_name":  self.level.name,
                                                            "is_endless":  self.level.isEndless,
                                                            "score": self.score])
        let gameOverView = TitleButtonsView(frame: .zero,
                                            buttonModels: [
            ButtonViewModel(text: "try again".localiz(), action: {
                Amplitude.instance().logEvent("LevelFailed_TryAgain_Taped",
                                              withEventProperties: ["level_index": self.index ?? "",
                                                                    "level_name":  self.level.name,
                                                                    "is_endless":  self.level.isEndless,
                                                                    "score": self.score])
                guard let vc = self.vc else {
                    assertionFailure("viewController no found")
                    return 
                }
                vc.freezeInteraction()
                GamePresenter(vc: vc, startState: .first, level: self.level, progress: self.progress).present()
            }),
        ], title: title, topText: topText, imageName: "deadFace", backButtonIcon: .home, backButtonAction: {
            Amplitude.instance().logEvent("LevelFailed_Back_Taped",
                                          withEventProperties: ["level_index": self.index ?? "",
                                                                "level_name": self.level.name,
                                                                "is_endless": self.level.isEndless,
                                                                "score": self.score])
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
