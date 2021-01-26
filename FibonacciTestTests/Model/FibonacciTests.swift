//
//  FibonacciTestTests.swift
//  FibonacciTestTests
//
//  Created by Marco Maddalena on 07/01/2021.
//

import XCTest
@testable import FibonacciTest

class FibonacciTests: XCTestCase {
    
    func testFibonacciValue_IsSmallerThan_Int64Max() {
        // GIVEN
        let n = 10
        
        // WHEN
        let fibonacci = Fibonacci(n: n)
        
        // THEN
        XCTAssertEqual(fibonacci.value, 34)
        XCTAssertEqual(fibonacci.overflow, false)
    }
    
    func testFibonacciValue_IsBiggerThan_Int64Max() {
        // GIVEN
        let n = 94
        
        // WHEN
        let fibonacci = Fibonacci(n: n)
        
        // THEN
        XCTAssertEqual(fibonacci.value, nil)
        XCTAssertEqual(fibonacci.overflow, true)
    }
}
