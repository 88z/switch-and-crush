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
    private var battleFieldScene: BattleFieldScene!
    private var menuScene: OneActionScene!
    private var isOnboarding = true
    private var presenter: DefaultPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DefaultPresenter(vc: self)
        presenter.present()
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
            view.showsFPS = false
            view.showsNodeCount = false
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
    
    func updatePresenterWith(_ presenter: DefaultPresenter) {
        self.presenter = presenter
        self.presenter.present()
        
    }
    
}
