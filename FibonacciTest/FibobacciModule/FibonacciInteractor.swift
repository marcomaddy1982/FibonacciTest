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
    weak var presenter: FibonacciPresenterProtocol!
    private var values: [Int] = []
}

extension FibonacciInteractor: FibonacciInteractorProtocol {
    func loadFibonacci() {
        var index = 0
        var overflow = false

        DispatchQueue.global().async { [weak self] in
            while (!overflow) {
                let result = fib(Int(UInt64(index)))
                self?.values.append(result.0)
                self?.presenter.refresh(with: FibonacciViewModel(values: self?.values ?? []))
                index = index + 1
                overflow = result.1
            }
        }
    }
}

struct FibonacciViewModel {
    var values: [Int] = []
}

func fib(_ n: Int) -> (Int, Bool) {
    var a = 0
    var b = 1
    guard n > 1 else { return (a, false)  }

    var overflow = false
    
    (2...n).forEach { _ in
        let result = a.addingReportingOverflow(b)
        overflow = result.overflow
        if !result.overflow {
            (a, b) = (a + b, a)
        }
    }

    return (a, overflow)
}
