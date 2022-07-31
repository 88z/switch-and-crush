//
//  Shatterer.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 31.07.2022.
//

import Foundation
import SpriteKit

protocol Shatterer: AnyObject {
    func shatter(contactPoint: CGPoint)
}
