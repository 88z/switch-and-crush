//
//  SKHelper.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 11.07.2022.
//

import Foundation
import SpriteKit

extension SKScene {
    func convertRect(_ rect:CGRect, from node:SKNode) -> CGRect{
        let origin = self.convert(rect.origin, from: node)
        return CGRect(x: origin.x, y: origin.y, width: rect.size.width, height: rect.size.height)
    }

}

