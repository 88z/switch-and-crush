//
//  QuadraticSolver.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 16.10.2020.
//

import Foundation

struct ComplexNumber {
    var real: Double
    var imaginary: Double
    
    public init(_ real: Double, _ imaginary: Double) {
        self.real = real
        self.imaginary = imaginary
    }
    
    public init(_ real: Double) {
        self.real = real
        self.imaginary = 0
    }
    
    var isReal: Bool {
        if imaginary == 0 { return true }
        return false
    }
}


extension ComplexNumber {
    static func zero() -> Self {
        return ComplexNumber(0, 0)
    }
}

extension ComplexNumber: CustomStringConvertible {
    var description: String {
        return "(Real: \(real), Imaginary: \(imaginary)"
    }
}

func linearSolve(a: Double, b: Double) -> [ComplexNumber] {
    if a == 0 {
        return []
    }
    
    return [ComplexNumber(-b/a)]
}

func quadraticSolve(a: Double, b: Double, c: Double, threshold: Double = 0.0001) -> [ComplexNumber] {
    if a == 0 { return linearSolve(a: b, b: c) }
    
    var roots = [ComplexNumber]()
    
    var d = pow(b, 2) - 4*a*c // discriminant
    
    // Check if discriminate is within the 0 threshold
    if -threshold < d && d < threshold { d = 0 }
    
    if d > 0 {
        
        let x_1 = ComplexNumber((-b + sqrt(d))/(2*a))
        let x_2 = ComplexNumber((-b - sqrt(d))/(2*a))
        roots = [x_1, x_2]
        
    } else if d == 0 {
        
        let x = ComplexNumber(-b/(2*a))
        roots = [x, x]
        
    } else if d < 0 {
        
        let x_1 = ComplexNumber(-b/(2*a), sqrt(-d)/(2*a))
        let x_2 = ComplexNumber(-b/(2*a), -sqrt(-d)/(2*a))
        roots = [x_1, x_2]
        
    }
    
    return roots
}

func quadraticRealSolve(a: Double, b: Double, c: Double, threshold: Double = 0.0001) -> [Double]{
    let complexRoots = quadraticSolve(a: a, b: b, c: c)
    let realRoots = complexRoots.filter { (root) -> Bool in
        return root.isReal
    }
    return realRoots.map { (root) -> Double in
        return root.real
    }
}
