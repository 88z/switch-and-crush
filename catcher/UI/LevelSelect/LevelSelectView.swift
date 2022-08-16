//
//  LevelSelectView.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import UIKit
import PinLayout

protocol LevelSelectViewDelegate: AnyObject {
    func didSelectLevel(at index: Int, levelSelectView:LevelSelectView)
}

class LevelSelectView: UIView, LevelSelectButtonDelegate {
    private weak var title: UILabel?
    private weak var buttonsContainer: UIScrollView?
    private var buttons: [UIView] = []
    weak var delegate:  LevelSelectViewDelegate?
    
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
        for i in 0..<models.count {
            let button = LevelSelectButton(model: models[i])
            buttonsContainer?.addSubview(button)
            buttons.append(button)
            button.delegate = self
        }
        buttonsContainer?.contentSize = CGSize(width: buttonsContainerWidth, height: buttonsContainerHeight)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title?.pin
            .sizeToFit()
            .hCenter()
            .top(pin.safeArea.top + 182)
        
        buttonsContainer?.pin
            .hCenter()
            .bottom(0)
            .top(to: title!.edge.bottom)
            .marginTop(45)
            .width(buttonsContainerWidth)
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.pin.width(93)
            button.pin.height(buttonSide)
            if i < 2 {
                button.pin.top(1)
            } else {
                let topButton = buttons[i-2]
                button.pin.top(to: topButton.edge.bottom).marginTop(buttonVSpace)
            }
            if i % 2 == 0{
                button.pin.left(1)
            } else {
                let leftButton = buttons[i-1]
                button.pin.left(to: leftButton.edge.right).marginLeft(30)
            }
        }
    }
    
    func pressed(_ button: LevelSelectButton) {
        guard let index = buttons.firstIndex(of: button) else {
            return
        }
        self.delegate?.didSelectLevel(at: index, levelSelectView: self)
    }
}
