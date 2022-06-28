//
//  Colors.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 25.10.2020.
//

import Foundation
import SpriteKit

extension UIColor {
    static func background() -> UIColor{
        return UIColor(red: 22/255, green: 0/255, blue: 30/255, alpha: 1)
    }
    
    static func first() -> UIColor{
        return UIColor(red: 0, green: 157/255, blue: 220/255, alpha: 1)
    }
    
    static func second() -> UIColor{
        return UIColor(red: 219/255, green: 41/255, blue: 85/255, alpha: 1)
    }
    
    static func grid() -> UIColor{
        return UIColor(red: 55/255, green: 41/255, blue: 61/255, alpha: 1)
    }
    
    static func text() -> UIColor{
        return UIColor(red: 237/255, green: 210/255, blue: 224/255, alpha: 1)
    }
}

