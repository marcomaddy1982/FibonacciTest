//
//  FibonacciPresenter.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import Foundation

protocol FibonacciPresenterProtocol: class {
    func viewDidLoad()
    func fibonacciDidComplete()
    func refresh(with viewModel: FibonacciViewModel)
}

class FibonacciPresenter {

    weak var viewController: FibonacciViewProtocol!
    var router: FibonacciRouterProtocol!
    var interactor: FibonacciInteractorProtocol!
}

extension FibonacciPresenter: FibonacciPresenterProtocol {
    func viewDidLoad() {
        interactor.loadFibonacci()
    }
    
    func fibonacciDidComplete() {
        router.presentCompletionAlert()
    }
    
    func refresh(with viewModel: FibonacciViewModel) {
        viewController.refresh(with: viewModel)
    }
}
