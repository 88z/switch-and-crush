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
    func uiSceneElementPressed(scene: UIScene, element: UISceneElement)
}

class UIScene:SKScene {
    var uiSceneDelegate: UISceneDelegate?
    let elements: [UISceneElement]
    let uifreezeTime: CGFloat
    
    init(size: CGSize, uifreezeTime: CGFloat = 0, elements: [UISceneElement]) {
        self.elements = elements
        self.uifreezeTime = uifreezeTime
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
            if element is UISceneButton {
                self.addButton(element as! UISceneButton)
            }
        }
    }
    
    func addText(_ text:UISceneText) {
        let node = TextTypeNode(text: text.text, font: text.font, color: text.color)
        node.preferredMaxLayoutWidth = 300
        node.numberOfLines = 10
        node.position = text.position
        node.horizontalAlignmentMode = .center
        node.name = text.name
        self.addChild(node)
    }
    
    func addButton(_ button: UISceneButton) {
        let node = ButtonNode(text: button.text, font: button.font, color: button.color)
        node.position = button.position
        node.name = button.name
        self.addChild(node)
        
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        for element in elements {
            add(element)
        }
        if uifreezeTime == 0 {
            return
        }
        
        view.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: uifreezeTime, repeats: false, block: { [unowned self] timer in
            view.isUserInteractionEnabled = true
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for element in elements {
            guard let node = childNode(withName: element.name) else {
                continue
            }
            for touch in touches {
                let location = touch.location(in: self)
                if node.contains(location) {
                    self.uiSceneDelegate?.uiSceneElementPressed(scene: self, element: element)
                    return
                }
            }
            
        }
        uiSceneDelegate?.uiScenePressed(scene: self)
    }
    
}
