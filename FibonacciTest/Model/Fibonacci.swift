//
//  Fibonacci.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import Foundation

struct Fibonacci {
    
    var n: Int = 0
    var value: Int?
    var overflow: Bool = false
    
    init(n: Int) {
        self.n = n
        
        var a = 0
        var b = 1
        guard n > 1 else {
            self.value = a
            self.overflow = false
            return
        }
        
        (2...n).forEach { _ in
            let result = a.addingReportingOverflow(b)
            self.overflow = result.overflow
            if !result.overflow {
                (a, b) = (a + b, a)
            }
            self.value = !overflow ? a : nil
        }
    }
}

struct FibonacciViewModel {
    var values: [Int] = []
}
