//
//  ButtonViewModel.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 06.11.2022.
//

import Foundation

class ButtonViewModel {
    let text: String
    let action:()->Void
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}
