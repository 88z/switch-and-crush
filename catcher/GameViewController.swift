//
//  GameViewController.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SKSceneDelegate, BattleDelegate, MenuDelegate {
    
    

    private var backgroundManager: InfiniteBackgroundManager?
    private var borderManager: InfinoteBorderManager?
    
    private var menuView: SKView?
    private var battleFieldScene: BattleFieldScene?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup () {
        if let view = self.view as! SKView? {
            view.presentScene(nil)
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
            let scene = BattleFieldScene(size: view.bounds.size)
            scene.battleDelegate = self
            scene.scaleMode = .aspectFill
            scene.delegate = self
            battleFieldScene = scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
            backgroundManager = InfiniteBackgroundManager(scene: scene, textureGenerator: GridGenerator())
        
            let menuView = SKView(frame: view.bounds)
            menuView.ignoresSiblingOrder = true
            menuView.showsFPS = false
            menuView.showsNodeCount = false
            menuView.showsPhysics = false
            menuView.backgroundColor = .clear
            self.menuView = menuView
            
            let menuScene = MenuScene(size: menuView.bounds.size)
            menuScene.menuDelegate = self
            menuScene.scaleMode = .aspectFill
            menuScene.backgroundColor = .clear
            view.addSubview(menuView)
            menuView.presentScene(menuScene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        scene.update(currentTime)
        backgroundManager?.swapIfNeeded()
    }
    
    func battleIsOver() {
        
        setup()
        menuView?.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [unowned self] timer in
            menuView?.isUserInteractionEnabled = true
            view.isUserInteractionEnabled = true
        })
    }
    
    func startGamePressed() {
        menuView?.removeFromSuperview()
        battleFieldScene?.startBattle()
    }
}
