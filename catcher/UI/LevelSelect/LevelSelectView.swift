//
//  LevelSelectView.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 14.08.2022.
//

import Foundation
import UIKit
import PinLayout

class LevelSelectView: UIScrollView, LevelSelectButtonDelegate {
    private weak var title: UILabel?
    private weak var backButton: UIButton?
    private weak var buttonToScroll: UIView?
    private weak var buttonsContainer: UIView?
    private weak var scrollView: UIScrollView?
    private var buttons: [UIView] = []
    
    private let buttonsContainerWidth:CGFloat = 220
    private let buttonSide: CGFloat = 95
    private let buttonVSpace: CGFloat = 18
    private var buttonsContainerHeight:CGFloat {
        get {
            let rowCount = ceil(CGFloat(buttons.count)/2)
            return rowCount * buttonSide + (rowCount-1)*buttonVSpace
        }
    }
    private let levelSelectAction:(_: Int)->Void
    private let backButtonAction: ()->Void
    
    init(frame: CGRect, buttonModels: [LevelButtonModel], backButtonAction:@escaping ()->Void, levelSelectAction: @escaping (_: Int)->Void) {
        self.levelSelectAction = levelSelectAction
        self.backButtonAction = backButtonAction
        super.init(frame: frame)
        backgroundColor = .clear
        
        let title = UILabel(frame: .zero)
        title.text = "Select Level".localiz()
        title.textColor = .text()
        title.font = FONT(size: 24)
        addSubview(title)
        self.title = title
        
        let scrollView = UIScrollView(frame: .zero)
        addSubview(scrollView)
        self.scrollView = scrollView
        let buttonsContainer = UIView(frame: .zero)
        scrollView.addSubview(buttonsContainer)
        self.buttonsContainer = buttonsContainer
        initButtons(models: buttonModels)
        
        let backButton = UIButton(frame: .zero)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        backButton.isHidden = true
        self.backButton = backButton
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            guard let buttonToScroll = self?.buttonToScroll else {
                return
            }
            let frameToScroll = buttonToScroll.convert(buttonToScroll.bounds, to: scrollView)
            self?.scrollView?.scrollRectToVisible(frameToScroll, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButtons(models: [LevelButtonModel]) {
        for model in models {
            let button = LevelSelectButton(model: model)
            buttonsContainer?.addSubview(button)
            buttons.append(button)
            button.delegate = self
            if model.state == .current {
                buttonToScroll = button
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title?.pin
            .sizeToFit()
            .hCenter()
            .top(pin.safeArea.top + 82)
        scrollView?.pin
            .top(to: title!.edge.bottom)
            .left()
            .right()
            .bottom()
            .hCenter()
            .marginTop(25)
        buttonsContainer?.pin
            .hCenter()
            .height(buttonsContainerHeight)
            .top()
            .width(buttonsContainerWidth)
            .marginTop(25)
        backButton?.pin
            .sizeToFit()
            .bottom(to:title!.edge.top)
            .marginBottom(73)
            .left(34)
        
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
        scrollView?.contentSize = CGSize(width: bounds.size.width, height: buttonsContainerHeight + 100)
    }
    
    func pressed(_ button: LevelSelectButton) {
        guard let index = buttons.firstIndex(of: button) else {
            return
        }
        levelSelectAction(index)
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        backButtonAction()
    }
}
