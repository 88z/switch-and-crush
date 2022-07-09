//
//  TypeTextNode.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 01.11.2020.
//

import Foundation
import SpriteKit

class TextTypeNode: SKLabelNode {
    let finalColor: UIColor
    
    init (text: String, font: UIFont, color: UIColor) {
        self.finalColor = color
        super.init()
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([.foregroundColor: UIColor.clear, .font: font], range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedText
        
        type(delay: 0.05)
    }
    
    private func type(delay: Double) {
        guard let attributedText = attributedText?.mutableCopy() as? NSMutableAttributedString else  {
            return
        }
        var secondsToWait = 0
        for i in 0 ..< attributedText.length {
            let index = attributedText.string.index(attributedText.string.startIndex, offsetBy: i)
            if attributedText.string[index] == " " {
                continue
            }
            secondsToWait += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(secondsToWait)*delay) {
                attributedText.addAttributes([.foregroundColor: self.finalColor,], range: NSRange(location: 0, length: i+1))
                self.attributedText = attributedText
            }

        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
