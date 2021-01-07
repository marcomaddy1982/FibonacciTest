//
//  FibonacciRouter.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import UIKit

protocol FibonacciRouterProtocol {
    
}

class FibonacciRouter {
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(router: self)
        _viewController = viewController
        return viewController
    }

    private let builder: FibonacciWireFrame
    private weak var _viewController: ViewController?

    init() {
        builder = FibonacciWireFrame()
    }
}

extension FibonacciRouter: FibonacciRouterProtocol {
    
}

struct FibonacciWireFrame {

    func build(router: FibonacciRouterProtocol) -> ViewController {

        let viewController = ViewController.instantiateFromStoryboard(withName: "Main")
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

import UIKit

extension UIViewController {
    /// Create a view controller from a storyboard.
    /// This method will cause a `fatalError` if no view controller of correct type could be loaded!
    ///
    /// - Parameters:
    ///   - name: The name of the storyboard
    ///   - id: An optional identifier. If set to `nil` the initial view controller is returned.
    ///   - bundle: The bundle of the view controller. If bundle is `nil` the same bundle for view controller and storyboard is assumed
    /// - Returns: A newly created view controller.
    public static func instantiateFromStoryboard(withName name: String, id: String? = nil, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: bundle ?? Bundle(for: self))

        if let id = id {
            return storyboard.withId(id)
        } else {
            return storyboard.initial()
        }
    }
}

extension UIStoryboard {
    fileprivate func initial<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Could not instantiate \(T.self) in \(self)")
        }
        return viewController
    }

    fileprivate func withId<T: UIViewController>(_ id: String) -> T {
        guard let viewController = instantiateViewController(withIdentifier: id) as? T else {
            fatalError("Could not instantiate \(T.self) in \(self) for \(id)")
        }
        return viewController
    }
}
