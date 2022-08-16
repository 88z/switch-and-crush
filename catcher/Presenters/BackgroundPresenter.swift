//
//  BackgroundPresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation

class BackgroundPresenter: BattleFieldPresenter{
    override func present(){
        super.present()
        battleFieldScene?.start(level: Level(initialObstacleTypes: [], initialSpeed: 0, acceleration: 0, name: "background", initialState: .first, userInterationEnabled: false, colorScheme: .blueRed), shouldShowCounter: false)
    }
}


