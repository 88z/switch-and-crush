//
//  Progress.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 13.08.2022.
//

import Foundation


class Progress {
    let userDefaults = UserDefaults.standard
    private let completedLevelsCountKey = "catcher.progress.completedLevelsCount"
    private let crushedObstaclesCountKey = "catcher.progress.crushedObstaclesCount"
    private let isOnboardingShownKey = "catcher.progress.isOnboardingShown"
    private let infiniteModeRecordKey = "catcher.progress.infiniteModeRecord"
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
    
    var infiniteModeRecord: Int {
        get {
            return userDefaults.integer(forKey: infiniteModeRecordKey)
        }
        set {
            userDefaults.set(newValue, forKey: infiniteModeRecordKey)
            userDefaults.synchronize()
        }
    }
    
    private func clean() {
        userDefaults.removeObject(forKey: isOnboardingShownKey)
        userDefaults.removeObject(forKey: infiniteModeRecordKey)
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
