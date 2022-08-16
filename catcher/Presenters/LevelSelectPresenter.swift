//
//  LevelSelectPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import SpriteKit

class LevelSelectPresenter: Presenter, LevelSelectViewDelegate {
    
    
    public weak var vc: GameViewController?
    let progress: ArcadeProgress
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
                    completionPart = CGFloat(progress.crushedObstaclesCount) / CGFloat(level.obstacleTypes.count)
                } else if index > progress.completedLevelsCount{
                    levelButtonState = .locked
                    completionPart = 0
                } else {
                    levelButtonState = .completed
                    completionPart = 1
                }
                
                return LevelButtonModel(isEnabled: index < progress.completedLevelsCount, title: String(index+1), state: levelButtonState, completionPart: completionPart)
            }
        }
    }
    
    init(vc: GameViewController, progress: ArcadeProgress) {
        self.progress = progress
        self.vc = vc
    }

    
    func present() {
        let levelSelectView = LevelSelectView(frame: .zero, buttonModels: levelButtonModels)
        levelSelectView.delegate = self
        vc?.show(uiView: levelSelectView)
    }
    
    func didSelectLevel(at index: Int, levelSelectView: LevelSelectView) {
        guard index < progress.levels.count,
              let vc = self.vc else {
            return
        }
        let level = progress.levels[index]
        
        GamePresenter(vc: vc, startState: .first, level: level).present()
        
    }
    
    
}
