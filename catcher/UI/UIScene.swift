//
//  MenuScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 24.10.2020.
//

import Foundation
import SpriteKit


protocol UISceneDelegate {
    func uiScenePressed(scene: UIScene)
}

class UIScene:SKScene {
    var uiSceneDelegate: UISceneDelegate?
    let elements: [UISceneElement]
    
    init(size: CGSize, elements: [UISceneElement]) {
        self.elements = elements
        super.init(size: size)
        self.backgroundColor = .clear
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(_ element:UISceneElement) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(element.delayBeforePresent)) {
            if element is UISceneText {
                self.addText(element as! UISceneText)
            }
        }
    }
    
    func addText(_ text:UISceneText) {
        let node = TextTypeNode(text: text.text, font: text.font, color: text.color)
        node.preferredMaxLayoutWidth = 300
        node.numberOfLines = 10
        node.position = text.position
        node.horizontalAlignmentMode = .center
        self.addChild(node)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        for element in elements {
            add(element)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        uiSceneDelegate?.uiScenePressed(scene: self)
    }
    
}
