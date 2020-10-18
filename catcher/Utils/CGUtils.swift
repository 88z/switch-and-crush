//
//  utils.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import Foundation
import CoreGraphics

func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y))
}

func CGUnitVector(from vector: CGVector) -> CGVector {
    let len = CGVectorLen(vector)
    guard len > 0 else {
        return .zero
    }
    return CGVector(dx: vector.dx/len, dy: vector.dy/len)
}

func CGVector(_ vector:CGVector, changeLenTo len:CGFloat) -> CGVector{
    guard len > 0 else {
        return .zero
    }
    let unit = CGUnitVector(from: vector)
    return CGVector(dx: unit.dx*len, dy:unit.dy*len)
}

func CGVectorLen(_ vector:CGVector) -> CGFloat{
    return hypot(vector.dx, vector.dy)
}

func randomBetween(_ first:CGFloat, and second:CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(second-first))) + CGFloat(first)
}

func randomPointOn(_ rect: CGRect) -> CGPoint {
    // 0 -- top
    // 1 -- left
    // 2 -- bottom
    // 3 -- right
    let side = arc4random_uniform(4)
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    if side == 0 {
        y = rect.maxY
        x = randomBetween(rect.minX, and: rect.maxX)
    } else if side == 1 {
        x = rect.minX
        y = randomBetween(rect.minY, and: rect.maxY)
    } else if side == 2 {
        y = rect.minY
        x = randomBetween(rect.minX, and: rect.maxX)
    } else if side == 3 {
        x = rect.maxX
        y = randomBetween(rect.minY, and: rect.maxY)
    }
    return CGPoint(x: x, y: y)
}

func randomPointInsideSquareWith(center: CGPoint, side:CGFloat) -> CGPoint {
    let x = randomBetween(center.x-side/2, and: center.x+side/2)
    let y = randomBetween(center.y-side/2, and: center.y+side/2)
    return CGPoint(x: x, y: y)
}

func randomPointOnCircleWith(center: CGPoint, radius: CGFloat) -> CGPoint {
        let theta = CGFloat(CGFloat.random(in: 0.33 ..< 0.66) * CGFloat.pi)
        // Convert polar to cartesian
        let x = radius * cos(theta)
        let y = radius * sin(theta)
        return CGPoint(x:x+center.x,y: y+center.y)
}

