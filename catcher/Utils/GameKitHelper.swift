//
//  GameKitHelper.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 06.02.2023.
//

import Foundation
import GameKit


class GameKitHelper {
    
    private let wasAuthenticatedKey = "GameKitHelper.wasAuthenticated"
    private let leaderBoardId = "switch_and_crush_main"
    private let userDefaults = UserDefaults.standard
    
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
    
    func submitEndlessLevelRecord(_ record:Int, closure: @escaping (_: Error?) -> Void) {
        guard isAuthenticated else {
            return
        }
        if #available(iOS 14.0, *) {
            GKLeaderboard.submitScore(record,
                                      context: 0,
                                      player: GKLocalPlayer.local,
                                      leaderboardIDs: [leaderBoardId]) { error in
                closure(error)
            }
        } else {
            let score = GKScore(leaderboardIdentifier: leaderBoardId)
            score.value = Int64(record)
            GKScore.report([score]) { (error) in
                closure(error)
            }
        }
    }
    
    func showLeaderboards(in vc:GameViewController) {
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.gameCenterDelegate = vc
        vc.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    private func test() {
        let leaderboard = GKLeaderboard()
        leaderboard.identifier = leaderBoardId
        leaderboard.loadScores { (scores, error) in
            if let error = error {
                print("Error loading leaderboard: \(error.localizedDescription)")
            } else {
                for score in scores! {
                    print("Player: \(score.player.alias), Score: \(score.value)")
                }
            }
        }
    }
}
