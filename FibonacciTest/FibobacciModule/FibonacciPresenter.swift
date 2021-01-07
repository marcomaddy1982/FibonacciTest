//
//  FibonacciPresenter.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import Foundation

protocol FibonacciPresenterProtocol: class {
    func viewDidLoad()
    func refresh(with viewModel: FibonacciViewModel)
}

class FibonacciPresenter {

    weak var viewController: FibonacciViewProtocol!
    var router: FibonacciRouterProtocol!
    var interactor: FibonacciInteractorProtocol!
}

extension FibonacciPresenter: FibonacciPresenterProtocol {
    func refresh(with viewModel: FibonacciViewModel) {
        viewController.refresh(with: viewModel)
    }
    
    func viewDidLoad() {
        interactor.loadFibonacci()
    }
}
