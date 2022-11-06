//
//  ButtonViewModel.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 06.11.2022.
//

import Foundation

class ButtonViewModel: Equatable {
    static func == (lhs: ButtonViewModel, rhs: ButtonViewModel) -> Bool {
        return lhs.text == rhs.text
    }
    
    let text: String
    let action:()->Void
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}
