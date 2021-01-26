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
    private var values: [Int] = []
    
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
        values = viewModel.values
        insertFibonacciValue()
    }
    
    private func insertFibonacciValue() {
        DispatchQueue.main.async { [weak self] in
            guard let index = self?.values.count else { return }
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: [IndexPath(row: index - 1, section: 0)],
                                       with: .fade)
            self?.tableView.endUpdates()
        }
    }
}
