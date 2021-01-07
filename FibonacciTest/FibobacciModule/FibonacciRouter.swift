//
//  FibonacciRouter.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import UIKit

protocol FibonacciRouterProtocol {
    func presentCompletionAlert()
}

class FibonacciRouter {
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(router: self)
        _viewController = viewController
        return viewController
    }

    private let builder: FibonacciWireFrame
    private weak var _viewController: FibonacciViewController?

    init() {
        builder = FibonacciWireFrame()
    }
}

extension FibonacciRouter: FibonacciRouterProtocol {
    
    func presentCompletionAlert() {
        let alert = UIAlertController(title: "Fibonacci",
                                      message: "The Fibonacci sequnce is completed for value less than \(Int64.max)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}

struct FibonacciWireFrame {

    func build(router: FibonacciRouterProtocol) -> FibonacciViewController {

        let viewController = FibonacciViewController.instantiateFromStoryboard(withName: "Main")
        let presenter = FibonacciPresenter()
        let interactor = FibonacciInteractor()

        // VC
        viewController.presenter = presenter

        // Presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router

        // Interactor
        interactor.presenter = presenter

        return viewController
    }
}
