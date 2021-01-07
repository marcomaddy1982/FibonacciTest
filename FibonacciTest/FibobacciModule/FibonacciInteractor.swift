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
    
    @objc
    private func calculateFibonacci() {
        !overflow
            ? findFibonacci(for: index)
            : completeFibonacci()
    }
    
    private func findFibonacci(for value: Int) {
        DispatchQueue.global().async { [weak self] in
            guard let strongRef = self else { return }
            let fibonaci = Fibonacci(n: strongRef.index)
            guard let value = fibonaci.value else { return }
            strongRef.values.append(value)
            strongRef.presenter.refresh(with: FibonacciViewModel(values: strongRef.values))
            strongRef.overflow = fibonaci.overflow
            strongRef.index+=1
        }
    }
    
    private func completeFibonacci() {
        timer?.invalidate()
        presenter.fibonacciDidComplete()
    }
}
