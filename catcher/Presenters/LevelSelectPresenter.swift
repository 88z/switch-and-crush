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
    
    private var levelButtonModels: [LevelButtonModel] {
        get {
            return progress.levels.enumerated().map {
                let index = $0
                let level = $1
                let levelButtonState: LevelButtonState
                if index == progress.completedLevelsCount {
                    levelButtonState = .current
                } else if index > progress.completedLevelsCount{
                    levelButtonState = .locked
                } else {
                    levelButtonState = .completed
                }
                return LevelButtonModel(isEnabled: index < progress.completedLevelsCount, title: String(index), state: levelButtonState, completionPart: CGFloat(progress.crushedObstaclesCount) / CGFloat(level.obstacleTypes.count))
            }
        }
    }
    
    init(vc: GameViewController, progress: ArcadeProgress) {
        self.progress = progress
        self.vc = vc
    }

    
    func present() {
        vc?.show(uiView: LevelSelectView(frame: .zero, buttonModels: levelButtonModels))
    }
    
    
}
