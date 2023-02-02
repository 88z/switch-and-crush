//
//  LevelSelectButton.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 15.08.2022.
//

import Foundation
import UIKit

protocol LevelSelectButtonDelegate: AnyObject {
    func pressed(_ button: LevelSelectButton)
}

class LevelSelectButton: UIView {
    
    weak var title: UILabel?
    weak var iconImageView: UIImageView?
    weak var playLabel: UILabel?
    weak var padlockImageView: UIImageView?
    weak var checkImageView: UIImageView?
    weak var background: UIView?
    weak var button: UIButton?
    weak var border: CAShapeLayer?
    weak var delegate: LevelSelectButtonDelegate?
    
    var backgroundWidthPart: CGFloat
    
    init(model: LevelButtonModel) {
        self.backgroundWidthPart = model.completionPart
        super.init(frame: .zero)
        backgroundColor = .clear
        let border = CAShapeLayer()
        border.strokeColor = UIColor.text().cgColor
        border.lineWidth = 1
        border.fillColor = nil
        layer.addSublayer(border)
        self.border = border
        if model.state == .locked {
            border.lineDashPattern = [1, 4]
        }
        if model.completionPart > 0 {
            let background = UIView(frame: .zero)
            background.backgroundColor = UIColor.text()
            background.alpha = 0.2
            addSubview(background)
            self.background = background
        }
        
        switch model.state{
        case .current:
            let playLabel = UILabel(frame: .zero)
            playLabel.font = FONT(size: 16)
            playLabel.text = "play".localiz()
            playLabel.textColor = .text()
            addSubview(playLabel)
            self.playLabel = playLabel
        case .locked:
            let padlockImageView = UIImageView(image: UIImage(named: "Padlock"))
            padlockImageView.alpha = 0.5
            addSubview(padlockImageView)
            self.padlockImageView = padlockImageView
        case .completed:
            let checkImageView = UIImageView(image: UIImage(named: "Check"))
            checkImageView.alpha = 1
            addSubview(checkImageView)
            self.checkImageView = checkImageView
        }
        
        if [LevelButtonState.current, LevelButtonState.completed].contains(model.state) {
            let button = UIButton(frame: .zero)
            button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
            addSubview(button)
            self.button = button
        }
        
        if model.title.count > 0 {
            let title = UILabel(frame: .zero)
            title.text = model.title
            title.textColor = .text()
            title.textAlignment = .center
            if model.state == .locked {
                title.alpha = 0.65
            }
            
            if title.text == ENDLESS_LEVEL_TITLE {
                title.font = ENDLESS_LEVEL_TITLE_FONT(size: 40)
            } else {
                title.font = FONT(size: 36)
            }
            
            
            addSubview(title)
            self.title = title
        } else if model.iconName.count > 0 {
            let iconImageView = UIImageView(image: UIImage(named: model.iconName))
            if model.state == .locked {
                iconImageView.alpha = 0.65
            }
            addSubview(iconImageView)
            self.iconImageView = iconImageView
        }
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let borderRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        border?.path = UIBezierPath(rect: borderRect).cgPath
        border?.frame = borderRect

        title?.pin.hCenter().top(15)
        if title?.text == ENDLESS_LEVEL_TITLE {
            title?.pin.height(36)
                .left()
                .right()
        } else {
            title?.pin.sizeToFit()
        }
        
        iconImageView?.pin
            .hCenter()
            .top(15)
            .height(35)
            .left()
            .right()

        background?.pin.left(0).top(0).bottom(0).width(bounds.size.width*backgroundWidthPart)
        playLabel?.pin.bottom(14).hCenter().sizeToFit()
        padlockImageView?.pin.sizeToFit().hCenter().bottom(10)
        checkImageView?.pin.sizeToFit().hCenter().bottom(15)
        button?.pin.top(0).left(0).right(0).bottom(0)
    }
    
    @IBAction func pressed(_ sender: UIButton) {
        delegate?.pressed(self)
    }
}
