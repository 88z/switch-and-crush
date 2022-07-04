//
//  BasePresenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//



import Foundation
import SpriteKit

class BasePresenter: NSObject, GamePresenter, BattleFieldSceneDelegate, BattleDelegate, UISceneDelegate {
    
    private var backgroundManager: InfiniteBackgroundManager?
    public weak var vc: GameViewController?
    public weak var battleFieldScene: BattleFieldScene!
    
    public let heroTopOffset = CGFloat(250)
    required init (vc: GameViewController) {
        self.vc = vc
    }

    func present(){
        let battleFieldScene = BattleFieldScene(size: UIScreen.main.bounds.size, heroTopOffset: heroTopOffset)
        battleFieldScene.battleDelegate = self
        battleFieldScene.scaleMode = .resizeFill
        battleFieldScene.delegate = self
        backgroundManager = InfiniteBackgroundManager(scene: battleFieldScene, textureGenerator: GridGenerator())
        vc?.showBattleField(scene: battleFieldScene)
        self.battleFieldScene = battleFieldScene
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        scene.update(currentTime)
        backgroundManager?.swapIfNeeded()
    }
    
    
    func crashed() {
    
    }
    
    func didFinish(level:Level) {
        
    }
    
    func uiScenePressed(scene: UIScene) {
        
    }
    
    func crashAnimated(scene: BattleFieldScene) {
        
    }
}
