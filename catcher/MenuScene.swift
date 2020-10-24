//
//  MenuScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit

protocol MenuDelegate {
    func startGamePressed()
}

class MenuScene:SKScene {
    var menuDelegate: MenuDelegate?
    override func didMove(to view: SKView) {
        let startGame = SKLabelNode(fontNamed: "Helvetica-Light")
        startGame.text = "Tap to Start"
        startGame.fontSize = 30
        startGame.fontColor = State.first.color
        startGame.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startGame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        menuDelegate?.startGamePressed()
    }
    
}
