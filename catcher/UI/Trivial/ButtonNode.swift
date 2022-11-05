//
//  ButtonNode.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.07.2022.
//

import Foundation
import SpriteKit

class ButtonNode: SKNode {
    let finalColor: UIColor
    let padding:CGFloat = 20
    init (text: String, font: UIFont, color: UIColor, width:CGFloat = 0) {
        self.finalColor = color
        super.init()
        
        let labelNode = SKLabelNode()
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([.foregroundColor: finalColor, .font: font], range: NSRange(location: 0, length: text.count))
        labelNode.attributedText = attributedText
        labelNode.horizontalAlignmentMode = .center
        self.addChild(labelNode)
        
        let wdth = width > 0 ? width : labelNode.frame.width+2*padding
        let borderNode = SKShapeNode(rect:CGRect(x: 0-wdth/2, y: labelNode.frame.minY-padding, width: wdth, height: labelNode.frame.height+2*padding))
        borderNode.strokeColor = finalColor
        self.addChild(borderNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
