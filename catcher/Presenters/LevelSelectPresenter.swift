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
                    completionPart = CGFloat(progress.crushedObstaclesCount) / CGFloat(level.capacity)
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
        let levelSelectView = LevelSelectView(frame: .zero, buttonModels: levelButtonModels, levelSelectAction: { (index: Int) in
            guard index < self.progress.levels.count,
                  let vc = self.vc else {
                return
            }
            let level = self.progress.levels[index]
            
            GamePresenter(vc: vc, startState: .first, level: level, progress: self.progress).present()
        })
        vc?.show(uiView: levelSelectView)
    }
    
}
