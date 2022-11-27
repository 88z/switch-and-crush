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

extension SKShapeNode {
    convenience init(arcWithCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, width: CGFloat){
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let innerPath = UIBezierPath()
        let innerRadius = radius-width
        innerPath.addArc(withCenter: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let innerCircleEnd = innerPath.currentPoint
        
        path.addLine(to: innerCircleEnd)
        path.addArc(withCenter: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        path.close()
        self.init(path: path.cgPath)
    }
}

extension SKNode {
    func descendants(with name: String) -> [SKNode] {
        var descendants:[SKNode] = []
        descendants.append(contentsOf: self[name])
        for child in children {
            descendants.append(contentsOf: child.descendants(with: name))
        }
        return descendants
    }
    
    func absoluteZPosition() -> CGFloat {
        var node = self
        var zPosition = node.zPosition
        while node.parent != nil {
            zPosition+=node.parent!.zPosition
            node = node.parent!
        }
        return zPosition
    }
}
