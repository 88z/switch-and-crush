//
//  Progress.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 13.08.2022.
//

import Foundation
import Amplitude


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
            let identify = AMPIdentify()
                .set("completedLevelsCount", value: NSNumber(value: newValue))
            Amplitude.instance().identify(identify!)
            userDefaults.set(newValue, forKey: completedLevelsCountKey)
            userDefaults.synchronize()
        }
    }
    var crushedObstaclesCount: Int {
        get {
            return userDefaults.integer(forKey: crushedObstaclesCountKey)
        }
        set {
            let identify = AMPIdentify()
                .set("crushedObstaclesCount", value: NSNumber(value: newValue))
            Amplitude.instance().identify(identify!)
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
            let identify = AMPIdentify()
                .set("infiniteModeRecord", value: NSNumber(value: newValue))
            Amplitude.instance().identify(identify!)
            userDefaults.set(newValue, forKey: infiniteModeRecordKey)
            userDefaults.synchronize()
        }
    }
    
    var lastCompletedLevel: Level? {
        get {
            guard completedLevelsCount > 0 else {
                return nil
            }
            return levels[completedLevelsCount-1]
        }
    }
    
    private func clean() {
        userDefaults.removeObject(forKey: isOnboardingShownKey)
        userDefaults.removeObject(forKey: infiniteModeRecordKey)
        userDefaults.removeObject(forKey: crushedObstaclesCountKey)
        userDefaults.removeObject(forKey: completedLevelsCountKey)
    }
    
    let levels: [Level]
    init(levelFactory: LevelFactory) {
        self.levels = levelFactory.levels
        clean()
    }
    
    func levelAfter(_ level:Level) -> Level? {
        guard let i = (levels.firstIndex { l in
            l.name == level.name
        }) else {
            return nil
        }
        
        if i >= levels.count-1 {
            return nil
        } else {
            return levels[i+1]
        }
    }
    
    func index(of level: Level) -> Int? {
        return levels.firstIndex { l in
            l.name == level.name
        }
    }
    
    
}
