//
//  ViewController.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import UIKit

protocol FibonacciViewProtocol: class {
    func refresh(with viewModel: FibonacciViewModel)
}

class FibonacciViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    var presenter: FibonacciPresenterProtocol!
    private var values: [Int] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fibonacci"
        configureTableView()
        presenter.viewDidLoad()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = FibonacciCellView.height
        tableView.rowHeight = FibonacciCellView.height
        tableView.register(UINib(nibName: "FibonacciCellView", bundle: nil),
                           forCellReuseIdentifier: "FibonacciCellView")
    }
}

extension FibonacciViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FibonacciCellView = tableView.dequeueReusableCell(withIdentifier: "FibonacciCellView",
                                                                    for: indexPath) as! FibonacciCellView
        cell.configure(with: UInt64(values[indexPath.row]))
        return cell
    }
}

extension FibonacciViewController: FibonacciViewProtocol {
    func refresh(with viewModel: FibonacciViewModel) {
        self.values = viewModel.values
    }
}
