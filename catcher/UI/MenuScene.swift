//
//  MenuScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

protocol OneActionSceneDelegate {
    func oneActionScenePressed(scene: OneActionScene)
}

class OneActionScene:SKScene {
    var oneActionSceneDelegate: OneActionSceneDelegate?
    private var text = ""
    init(size: CGSize, text: String) {
        super.init(size: size)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let startGame = SKLabelNode(fontNamed: "Helvetica-Light")
        startGame.text = text
        startGame.fontSize = 30
        startGame.fontColor = State.first.color
        startGame.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startGame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        oneActionSceneDelegate?.oneActionScenePressed(scene: self)
    }
    
}
