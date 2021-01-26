//
//  Fibonacci.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import Foundation

class Fibonacci {
    var value: Int?
    var overflow: Bool = false
    
    func calculate(for n: Int) {
        var a = 0
        var b = 1
        guard n > 1 else {
            value = a
            overflow = false
            return
        }
        
        (2...n).forEach { _ in
            let result = a.addingReportingOverflow(b)
            overflow = result.overflow
            if !result.overflow {
                (a, b) = (a + b, a)
            }
            value = !overflow ? a : nil
        }
    }
}

struct FibonacciViewModel {
    var values: [Int] = []
}
