//
//  GameKitHelper.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 06.02.2023.
//

import Foundation
import GameKit

class GameKitHelper {
    let wasAuthenticatedKey = "GameKitHelper.wasAuthenticated"
    let userDefaults = UserDefaults.standard
    
    var wasAuthenticated: Bool {
        get {
            return userDefaults.bool(forKey: wasAuthenticatedKey)
        }
        set {
            userDefaults.set(newValue, forKey: wasAuthenticatedKey)
            userDefaults.synchronize()
        }
    }
    
    var isAuthenticated: Bool {
        get {
            return GKLocalPlayer.local.isAuthenticated
        }
    }
    
    func authenticate(closure: @escaping (_: UIViewController?, _: Error?) -> Void) {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if GKLocalPlayer.local.isAuthenticated {
                self.wasAuthenticated = true
            }
            closure(viewController, error)
        }
    }
}
