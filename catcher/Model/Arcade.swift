//
//  Arcade.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 13.08.2022.
//

import Foundation

class Arcade {
    private let progress: ArcadeProgress
    var comopletedLevelsCount: Int {
        get {
            return progress.completedLevelsCount
        }
        set {
            progress.completedLevelsCount = newValue
        }
    }
    
    var crushedObstaclesCount: Int {
        get{
            return progress.crushedObstaclesCount
        }
        set {
        progress.crushedObstaclesCount = newValue
        }
    }
    init(progress: ArcadeProgress) {
        self.progress = progress
    }
}
