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
        let levelFactory = LevelFactory()
        battleFieldScene?.start(level: levelFactory.infiniteLevel(), shouldShowCounter: false, shouldPlaceHero: false)
        battleFieldScene.isDimmed = true
    }
}


