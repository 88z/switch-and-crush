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
    let elements: [OneActionSceneElement]
    
    init(size: CGSize, elements: [OneActionSceneElement]) {
        self.elements = elements
        super.init(size: size)
        self.backgroundColor = .clear
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(_ element:OneActionSceneElement) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(element.delayBeforePresent)) {
            if element is OneActionSceneText {
                self.addText(element as! OneActionSceneText)
            }
        }
    }
    
    func addText(_ text:OneActionSceneText) {
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
        oneActionSceneDelegate?.oneActionScenePressed(scene: self)
    }
    
}
