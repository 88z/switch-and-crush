//
//  utils.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 30.09.2020.
//

import Foundation
import UIKit

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

func randomBetween(_ first:Int, and second:Int) -> Int {
    return Int(arc4random_uniform(UInt32(second-first))) + first
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
        x = CGFloat(randomBetween(Int(rect.minX), and: Int(rect.maxX)))
    } else if side == 1 {
        x = rect.minX
        y = CGFloat(randomBetween(Int(rect.minY), and: Int(rect.maxY)))
    } else if side == 2 {
        y = rect.minY
        x = CGFloat(randomBetween(Int(rect.minX), and: Int(rect.maxX)))
    } else if side == 3 {
        x = rect.maxX
        y = CGFloat(randomBetween(Int(rect.minY), and: Int(rect.maxY)))
    }
    return CGPoint(x: x, y: y)
}

func randomPointInsideSquareWith(center: CGPoint, side:CGFloat) -> CGPoint {
    let x = CGFloat(randomBetween(Int(center.x-side/2), and: Int(center.x+side/2)))
    let y = CGFloat(randomBetween(Int(center.y-side/2), and: Int(center.y+side/2)))
    return CGPoint(x: x, y: y)
}

func randomPointOnCircleWith(center: CGPoint, radius: CGFloat) -> CGPoint {
        let theta = CGFloat(CGFloat.random(in: 0.33 ..< 0.66) * CGFloat.pi)
        // Convert polar to cartesian
        let x = radius * cos(theta)
        let y = radius * sin(theta)
        return CGPoint(x:x+center.x,y: y+center.y)
}

func CGPathFrom(cgPath: CGPath, movedTo point: CGPoint) -> CGPath {
    let bezeirPath = UIBezierPath(cgPath: cgPath)
    bezeirPath.apply(CGAffineTransform(translationX: point.x, y: point.y))
    return bezeirPath.cgPath
}
