//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 14/06/23.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    static let identifier: String = "CurrencyTableViewCell"
    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(currency: String, baseCurrency: KeyValueRatio?) {
        self.currencyLabel.text = currency
        selectedIcon.isHidden = baseCurrency?.key != currency
    }
    
    
}
