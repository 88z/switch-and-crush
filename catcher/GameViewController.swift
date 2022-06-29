//
//  GameViewController.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var uiView: SKView?
    private var menuScene: OneActionScene!
    private var isOnboarding = false
    private var presenter: GamePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter: GamePresenter
        if isOnboarding {
            presenter = OnboardingPresenter(vc: self)
        } else {
            presenter = DefaultPresenter(vc:self, showIntro: true, startState: State.first)
        }
        set(presenter: presenter)
    }

    func showUI(scene: SKScene) {
        uiView?.removeFromSuperview()
        let uiView = SKView(frame: view.bounds)
        uiView.ignoresSiblingOrder = true
        uiView.showsFPS = false
        uiView.showsNodeCount = false
        uiView.showsPhysics = false
        uiView.backgroundColor = .clear
        self.uiView = uiView
        view.addSubview(uiView)
        uiView.presentScene(scene)
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
    
    func set(presenter: GamePresenter) {
        self.presenter = presenter
        self.presenter.present()
        
    }
    
}
