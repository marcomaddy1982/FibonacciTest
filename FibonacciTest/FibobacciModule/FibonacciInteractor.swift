//
//  FibonacciInteractor.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import Foundation

protocol FibonacciInteractorProtocol {
    func loadFibonacci()
}

class FibonacciInteractor {
    private var values: [Int] = []
    private var index: Int = 1
    private var timer: Timer?
    private var overflow = false
    
    weak var presenter: FibonacciPresenterProtocol!
}

extension FibonacciInteractor: FibonacciInteractorProtocol {
    func loadFibonacci() {
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(calculateFibonacci),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func calculateFibonacci() {
        !overflow
            ? findFibonacci(for: index)
            : completeFibonacci()
    }
    
    private func findFibonacci(for value: Int) {
        let result = fibonacci(Int(UInt64(index)))
        guard let value = result.0 else { return }
        values.append(value)
        presenter.refresh(with: FibonacciViewModel(values: values))
        overflow = result.1
        index+=1
    }
    
    private func completeFibonacci() {
        timer?.invalidate()
        presenter.fibonacciDidComplete()
    }
    
    private func fibonacci(_ n: Int) -> (Int?, Bool) {
        var a = 0
        var b = 1
        guard n > 1 else { return (a, false) }

        var overflow = false
        
        (2...n).forEach { _ in
            let result = a.addingReportingOverflow(b)
            overflow = result.overflow
            if !result.overflow {
                (a, b) = (a + b, a)
            }
        }
        
        return (!overflow ? a : nil, overflow)
    }
}

struct FibonacciViewModel {
    var values: [Int] = []
}
