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
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        backButton?.pin
            .sizeToFit()
            .top(pin.safeArea.top + 109)
            .left(34)
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        guard let backButtonAction = backButtonAction else {
            assertionFailure("back button action is null")
            return
        }
        backButtonAction()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
