//
//  FibonacciCellView.swift
//  FibonacciTest
//
//  Created by Marco Maddalena on 07/01/2021.
//

import UIKit

extension FibonacciCellView {
    public static let height: CGFloat = 44.0
}

class FibonacciCellView: UITableViewCell {

    @IBOutlet private var labelValue: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        labelValue.text = nil
    }

    // MARK: Public Methods

    func configure(with value: UInt64) {
        labelValue.text = String(value)
    }
}
