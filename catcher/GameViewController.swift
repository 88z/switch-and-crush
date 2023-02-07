//
//  GameViewController.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import UIKit
import SpriteKit
import LanguageManager_iOS
import Amplitude

class GameViewController: UIViewController {
    
    private var uiView: UIView?
    private var battleFieldScene: SKScene?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let progress = Progress(levelFactory: ChallengingLevelFactory())
        if progress.isOnboardingShown {
            BackgroundPresenter(vc:self, progress: progress).present()
            let gk = GameKitHelper()
            if gk.wasAuthenticated {
                gk.authenticate { viewController, error in
                    if error != nil {
                        Amplitude.instance().logEvent("AppStart_GameCenterAuth_Error",
                                                      withEventProperties: ["error": error!.localizedDescription])
                    }
                    if viewController != nil  {
                        self.present(viewController!, animated: true)
                    }
                    LevelSelectPresenter(vc:self, progress: progress).present()
                }
            } else {
                LevelSelectPresenter(vc:self, progress: progress).present()
            }
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
        uiView.alpha = 0
        view.addSubview(uiView)
        UIView.animate(withDuration: 0.25, animations: {
          uiView.alpha = 1.0
        })
        self.uiView = uiView
        battleFieldScene?.alpha = 0.5
    }
    
    
    func hideUI() {
        uiView?.removeFromSuperview()
        uiView = nil
        battleFieldScene?.alpha = 1
    }
    
    func showBattleField(scene: SKScene) {
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = false
            battleFieldScene = scene
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
