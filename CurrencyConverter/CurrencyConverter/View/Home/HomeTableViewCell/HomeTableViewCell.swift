//
//  HomeTableViewCell.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 14/06/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier: String = "HomeTableViewCell"
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    var currentCurrency: KeyValueRatio?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        amountLabel.text = ""
        currencyLabel.text = ""
    }
    
    func setup(currentCurrency: KeyValueRatio, amount: String) {
        self.currentCurrency = currentCurrency
        self.currencyLabel.text = self.currentCurrency?.key
        self.amountLabel.text = amount
    }
    
}

