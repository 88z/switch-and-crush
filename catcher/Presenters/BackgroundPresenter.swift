//
//  BackgroundPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation

class BackgroundPresenter: BattleFieldPresenter{
    
    let progress: Progress
    
    init (vc: GameViewController, progress: Progress) {
        self.progress = progress
        super.init(vc: vc)
    }
    
    override func present(){
        super.present()
        battleFieldScene?.start(level: progress.lastCompletedLevel ?? progress.levels.first!, shouldShowCounter: false, shouldPlaceHero: false, mode: .endless)
        battleFieldScene.dim()
    }
}


