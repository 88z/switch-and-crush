//
//  Presenter.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

protocol Presenter {
    var vc: GameViewController? { get }
    func present()
}
