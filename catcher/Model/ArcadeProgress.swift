//
//  Progress.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 13.08.2022.
//

import Foundation


class ArcadeProgress {
    let userDefaults = UserDefaults.standard
    private let completedLevelsCountKey = "catcher.arcadeProgress.completedLevelsCount"
    private let crushedObstaclesCountKey = "catcher.arcadeProgress.crushedObstaclesCount"
    var completedLevelsCount: Int {
        get {
            return userDefaults.integer(forKey: completedLevelsCountKey)
        }
        set {
            userDefaults.set(newValue, forKey: completedLevelsCountKey)
        }
    }
    var crushedObstaclesCount: Int {
        get {
            return userDefaults.integer(forKey: crushedObstaclesCountKey)
        }
        set {
            userDefaults.set(newValue, forKey: crushedObstaclesCountKey)
        }
    }
    
}
