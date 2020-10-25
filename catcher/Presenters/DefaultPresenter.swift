//
//  GamePresented.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

class DefaultPresenter: NSObject, SKSceneDelegate, BattleDelegate, OneActionSceneDelegate {
    
    private var backgroundManager: InfiniteBackgroundManager?
    private weak var vc: GameViewController?
    private weak var battleFieldScene: BattleFieldScene!
    init (vc: GameViewController) {
        self.vc = vc
    }
    
    func present(){
        let battleFieldScene = BattleFieldScene(size: UIScreen.main.bounds.size)
        battleFieldScene.battleDelegate = self
        battleFieldScene.scaleMode = .resizeFill
        battleFieldScene.delegate = self
        backgroundManager = InfiniteBackgroundManager(scene: battleFieldScene, textureGenerator: GridGenerator())
        vc?.showBattleField(scene: battleFieldScene)
        self.battleFieldScene = battleFieldScene
        
        
        let menuScene = OneActionScene(size: UIScreen.main.bounds.size, text: "Tap to Start")
        menuScene.oneActionSceneDelegate = self
        menuScene.scaleMode = .aspectFill
        menuScene.backgroundColor = .clear
        vc?.showUI(scene: menuScene)
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        scene.update(currentTime)
        backgroundManager?.swapIfNeeded()
    }
    
    
    func crashed() {
        guard let vc = vc else {
            return
        }
        vc.freezeInteraction()
        let newPresenter = DefaultPresenter(vc: vc)
        vc.updatePresenterWith(newPresenter)
    }
    
    func levelFinished() {
        
    }
    
    func oneActionScenePressed(scene: OneActionScene) {
        vc?.hideUI()
        battleFieldScene?.start(level: Level(obstacleCount: 100, initialSpeed: 3, acceleration: 0.05))
    }
}
