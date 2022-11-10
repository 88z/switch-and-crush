//
//  GameViewController.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import UIKit
import SpriteKit
import GameplayKit
import LanguageManager_iOS

class GameViewController: UIViewController {
    
    private var uiView: UIView?
    private var menuScene: TrivialUIScene!
    private var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let progress = Progress(levelFactory: LevelFactory())
        if progress.isOnboardingShown {
            BackgroundPresenter(vc:self, progress: progress).present()
            ModeSelectPresenter(vc:self, progress: progress).present()
//            InfiniteStartPresenter(vc: self).present()
        } else {
            OnboardingPresenter(vc: self, progress: progress).present()
        }
    }

    func show(uiScene: SKScene) {
        uiView?.removeFromSuperview()
        let uiView = SKView(frame: view.bounds)
        uiView.ignoresSiblingOrder = true
        uiView.showsFPS = false
        uiView.showsNodeCount = false
        uiView.showsPhysics = false
        uiView.backgroundColor = .clear
        self.uiView = uiView
        view.addSubview(uiView)
        uiView.presentScene(uiScene)
    }
    
    func show(uiView: UIView) {
        self.uiView?.removeFromSuperview()
        uiView.frame = view.bounds
        view.addSubview(uiView)
        self.uiView = uiView
    }
    
    
    func hideUI() {
        uiView?.removeFromSuperview()
        uiView = nil
    }
    
    func showBattleField(scene: SKScene) {
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
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
    
    func freezeInteraction() {
        uiView?.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [unowned self] timer in
            uiView?.isUserInteractionEnabled = true
            view.isUserInteractionEnabled = true
        })
    }
    
}
