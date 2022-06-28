//
//  GridGenerator.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 03.10.2020.
//

import SpriteKit

class GridGenerator:InfiniteBackgroundTextureGenerator {
    
    func generate() -> SKTexture?{
        let cols = 3
        let rows = 3
        let blockSize = CGFloat(200)
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        
        UIColor.grid().setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return SKTexture(image: image!)
    }
}
