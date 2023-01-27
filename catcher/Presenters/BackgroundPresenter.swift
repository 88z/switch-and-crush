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
        battleFieldScene?.start(level: progress.lastCompletedLevel ?? progress.levels.first!, shouldShowCounter: false, shouldPlaceHero: false)
    }
    
    func presentEmpty() {
        super.present()
        let emptyLevel = Level(initialObstacleTypes: [], obstacleTypesForTail: [], capacity: 0, initialSpeed: 0, name: "empty", initialState: .random(), userInterationEnabled: false, colorScheme: .blueRed)
        battleFieldScene?.start(level: emptyLevel, shouldShowCounter: false, shouldPlaceHero: false)
    }
}


