//
//  Mask.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 23.10.2020.
//

import Foundation
import SpriteKit

struct Mask {
    let category: UInt32
    let collision: UInt32
    let contact: UInt32
    
    init(mask: UInt32){
        self.init(category: mask, collision: mask, contact: mask)
    }
    
    init(category: UInt32, collision: UInt32, contact: UInt32) {
        self.category = category
        self.collision = collision
        self.contact = contact
    }
}

extension SKPhysicsBody {
    func set(mask: Mask) {
        self.categoryBitMask = mask.category
        self.contactTestBitMask = mask.contact
        self.collisionBitMask = mask.collision
    }
    
    func setZeroMask(){
        self.collisionBitMask = 0b000
        self.categoryBitMask = 0b000
        self.contactTestBitMask = 0b000
    }
}
