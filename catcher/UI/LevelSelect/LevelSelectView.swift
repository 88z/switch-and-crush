//
//  LevelSelectView.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import UIKit
import PinLayout

class LevelSelectView: UIView {
    
    let title: UIView
    
    override init(frame: CGRect) {
        let title = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        title.text = "Select Level".localiz()
        title.textColor = .text()
        title.font = FONT(size: 24)
        self.title = title
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.pin
            .sizeToFit()
            .hCenter()
            .top(pin.safeArea.top + 182)
    }
}
