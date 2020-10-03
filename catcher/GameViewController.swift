//
//  GameViewController.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SKSceneDelegate {

    private var backgroundManager: InfiniteBackgroundManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.delegate = self
            
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
            
            backgroundManager = InfiniteBackgroundManager(scene: scene, textureGenerator: GridGenerator())
            
            let joystickView = SKView(frame: view.bounds)
            joystickView.ignoresSiblingOrder = true
            joystickView.showsFPS = false
            joystickView.showsNodeCount = false
            joystickView.showsPhysics = false
            joystickView.backgroundColor = .clear
            
            let joystickScene = JoystickScene(size: view.bounds.size)
            joystickScene.scaleMode = .aspectFill
            joystickScene.backgroundColor = .clear
            joystickScene.joystickDelegate = scene

            view.addSubview(joystickView)
            joystickView.presentScene(joystickScene)
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
}
