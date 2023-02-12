//
//  LevelSelectPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import SpriteKit
import Amplitude

class LevelSelectPresenter: Presenter {
    
    
    public weak var vc: GameViewController?
    let progress: Progress
    private var levelSelectView: UIView?
    
    private var levelButtonModels: [LevelButtonModel] {
        get {
            return progress.levels.enumerated().map {
                let index = $0
                let level = $1
                let levelButtonState: LevelButtonState
                let completionPart:CGFloat
                if index == progress.completedLevelsCount {
                    levelButtonState = .current
                    if level.isEndless {
                        completionPart = 0
                    } else {
                        completionPart = CGFloat(progress.crushedObstaclesCount) / CGFloat(level.capacity)
                    }
                    
                } else if index > progress.completedLevelsCount{
                    levelButtonState = .locked
                    completionPart = 0
                } else  {
                    levelButtonState = .completed
                    completionPart = 1
                }
                let title: String
                let iconName: String
                if level.isBoss {
                    title = ""
                    iconName = "skull"
                } else if level.isEndless {
                    title = ENDLESS_LEVEL_TITLE
                    iconName = ""
                } else {
                    title = String(index+1)
                    iconName = ""
                }
                return LevelButtonModel(isEnabled: index < progress.completedLevelsCount, title: title, iconName: iconName, state: levelButtonState, completionPart: completionPart)
            }
        }
    }
    
    init(vc: GameViewController, progress: Progress) {
        progress.regenerateLevels()
        self.progress = progress
        self.vc = vc
    }

    
    func present() {
        Amplitude.instance().logEvent("LevelSelect_Opened")
        let levelSelectView = LevelSelectView(frame: .zero, buttonModels: levelButtonModels, backButtonAction: {
            guard let vc = self.vc else {
                return
            }
            ModeSelectPresenter(vc:vc, progress: self.progress).present()
        }, levelSelectAction: { (index: Int) in
            
            guard index < self.progress.levels.count,
                  let vc = self.vc else {
                return
            }
            let level = self.progress.levels[index]
            Amplitude.instance().logEvent("LevelSelect_Level_Taped",
                                          withEventProperties: ["level_index": index,
                                                                "level_name": level.name,
                                                                "is_endless": level.isEndless])
            
            let gk = GameKitHelper()
            if level.isEndless && !gk.isAuthenticated && !gk.wasAuthenticationError {
                gk.authenticate { viewController, error in
                    if error != nil {
                        Amplitude.instance().logEvent("LevelSelect_InfiniteLevelGameCenterAuth_Error",
                                                      withEventProperties: ["error": error!.localizedDescription])
                    }
                    
                    guard viewController == nil else {
                        vc.present(viewController!, animated: true)
                        return
                    }
                    GamePresenter(vc: vc, startState: .first, level: level, progress: self.progress).present()
                }
            } else {
                GamePresenter(vc: vc, startState: .first, level: level, progress: self.progress).present()
            }
            
            
        }, bottomButtonAction: {
            let gk = GameKitHelper()
            Amplitude.instance().logEvent("LevelSelect_Leaderboard_Taped",
                                          withEventProperties: ["is_authenticated": gk.isAuthenticated])
            guard let vc = self.vc else {
                return
            }
            if !gk.isAuthenticated {
                gk.authenticate { viewController, error in
                    if error != nil {
                        Amplitude.instance().logEvent("LevelSelect_LeaderboardsGameCenterAuth_Error",
                                                      withEventProperties: ["error": error!.localizedDescription])
                    }
                    
                    guard viewController == nil else {
                        vc.present(viewController!, animated: true)
                        return
                    }
                    gk.showLeaderboards(in: vc)
                }
            } else {
                gk.showLeaderboards(in: vc)
            }
            
        })
        vc?.show(uiView: levelSelectView)
        
    }
    
}
