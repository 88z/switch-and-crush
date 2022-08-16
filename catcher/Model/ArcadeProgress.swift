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
    private let isOnboardingShownKey = "catcher.arcadeProgress.isOnboardingShown"
    var completedLevelsCount: Int {
        get {
            return userDefaults.integer(forKey: completedLevelsCountKey)
        }
        set {
            userDefaults.set(newValue, forKey: completedLevelsCountKey)
            userDefaults.synchronize()
        }
    }
    var crushedObstaclesCount: Int {
        get {
            return userDefaults.integer(forKey: crushedObstaclesCountKey)
        }
        set {
            userDefaults.set(newValue, forKey: crushedObstaclesCountKey)
            userDefaults.synchronize()
        }
    }
    var isOnboardingShown: Bool {
        get {
            return userDefaults.bool(forKey: isOnboardingShownKey)
        }
        set {
            userDefaults.set(newValue, forKey: isOnboardingShownKey)
            userDefaults.synchronize()
        }
    }
    
    private func clean() {
        userDefaults.removeObject(forKey: isOnboardingShownKey)
    }
    
    let levels: [Level]
    init(levelFactory: LevelFactory) {
        self.levels = [
            levelFactory.level1(),
            levelFactory.level2(),
            levelFactory.level3(),
        ]
//        clean()
    }
    
}
