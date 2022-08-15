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
    
    weak var title: UILabel?
    weak var buttonsContainer: UIScrollView?
    var buttons: [UIButton] = []
    
    private let buttonsContainerWidth:CGFloat = 220
    private let buttonSide: CGFloat = 95
    private let buttonVSpace: CGFloat = 18
    private var buttonsContainerHeight:CGFloat {
        get {
            let rowCount = ceil(CGFloat(buttons.count)/2)
            return rowCount * buttonSide + (rowCount-1)*buttonVSpace
        }
    }
    
    init(frame: CGRect, buttonModels: [LevelButtonModel]) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        let title = UILabel(frame: .zero)
        title.text = "Select Level".localiz()
        title.textColor = .text()
        title.font = FONT(size: 24)
        addSubview(title)
        self.title = title
        
        let buttonsContainer = UIScrollView(frame: .zero)
        addSubview(buttonsContainer)
        self.buttonsContainer = buttonsContainer
        initButtons(models: buttonModels)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButtons(models: [LevelButtonModel]) {
        for _ in 0..<models.count {
            let button = UIButton(frame: .zero)
            button.backgroundColor = .red
            buttonsContainer?.addSubview(button)
            buttons.append(button)
        }
        buttonsContainer?.contentSize = CGSize(width: buttonsContainerWidth, height: buttonsContainerHeight)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let title = title,
              let levelButtons = buttonsContainer else {
            return
        }
        title.pin
            .sizeToFit()
            .hCenter()
            .top(pin.safeArea.top + 182)
        
        levelButtons.pin
            .hCenter()
            .bottom(0)
            .top(to: title.edge.bottom)
            .marginTop(45)
            .width(buttonsContainerWidth)
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.pin.width(95)
            button.pin.height(buttonSide)
            if i < 2 {
                button.pin.top(0)
            } else {
                let topButton = buttons[i-2]
                button.pin.top(to: topButton.edge.bottom).marginTop(buttonVSpace)
            }
            if i % 2 == 0{
                button.pin.left(0)
            } else {
                let leftButton = buttons[i-1]
                button.pin.left(to: leftButton.edge.right).marginLeft(30)
            }
            
        }
    }
    
    
}
