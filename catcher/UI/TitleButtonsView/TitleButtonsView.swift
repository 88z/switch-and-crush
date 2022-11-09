//
//  TitleButtonsView.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 06.11.2022.
//

import Foundation
import UIKit
import PinLayout

class TitleButtonsView: UIView {
    
    let backButtonAction: (()->Void)?
    private weak var backButton: UIButton?
    private weak var titleLabel: UILabel?
    private var buttons: [UIButton] = []
    private var buttonBorders: [CAShapeLayer] = []
    
    private var actions:[()->Void] = []
    
    
    init(frame: CGRect, buttonModels: [ButtonViewModel], title:String?, backButtonAction: (()->Void)?) {
        self.backButtonAction = backButtonAction
        
        super.init(frame: frame)
        if backButtonAction != nil {
            let backButton = UIButton(frame: .zero)
            backButton.setImage(UIImage(named: "back"), for: .normal)
            addSubview(backButton)
            backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
            self.backButton = backButton
        }
        if title != nil {
            let titleLabel = UILabel(frame: .zero)
            let attributedString = NSMutableAttributedString(string: title ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 36
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

            titleLabel.attributedText = attributedString
            titleLabel.font = FONT(size: 24)
            titleLabel.textColor = .text()
            titleLabel.numberOfLines = 2
            
            addSubview(titleLabel)
            self.titleLabel = titleLabel
        }
        
        for model in buttonModels {
            let button = UIButton(frame: .zero)
            button.setTitle(model.text, for: .normal)
            let attributedText = NSMutableAttributedString(string: model.text)
            attributedText.addAttributes([.foregroundColor: UIColor.text(), .font: FONT(size: 24)], range: NSRange(location: 0, length: model.text.count))
            button.setAttributedTitle(attributedText, for: .normal)
            let border = CAShapeLayer()
            border.strokeColor = UIColor.text().cgColor
            border.lineWidth = 1
            border.fillColor = nil
            button.layer.addSublayer(border)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            buttonBorders.insert(border, at: 0)
            addSubview(button)
            buttons.insert(button, at: 0)
            actions.insert(model.action, at: 0)
        }
         
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.pin
            .sizeToFit()
            .hCenter()
            .top(pin.safeArea.top + 182)
        
        backButton?.pin
            .sizeToFit()
            .bottom(to:titleLabel!.edge.top)
            .marginBottom(73)
            .left(34)
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let prevButton = i == 0 ? nil : buttons[i-1]
            button.pin
                .width(UI_BUTTON_WIDTH)
                .height(UI_BUTTON_HEIGHT)
                .hCenter()
            if prevButton != nil {
                button.pin.bottom(to:prevButton!.edge.top).marginBottom(26)
            } else {
                button.pin.bottom(pin.safeArea.bottom).marginBottom(UI_BUTTON_BOTTOM_OFFSET)
            }
            let borderRect = CGRect(x: 0, y: 0, width: button.bounds.size.width, height: button.bounds.size.height)
            buttonBorders[i].path = UIBezierPath(rect: borderRect).cgPath
            buttonBorders[i].frame = borderRect
        }
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        guard let backButtonAction = backButtonAction else {
            assertionFailure("back button action is null")
            return
        }
        backButtonAction()
    }
    
    @IBAction private func buttonPressed(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of:sender) else {
            assertionFailure("button not found")
            return
        }
        actions[index]()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
