//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 14/06/23.
//

import UIKit

class CurrencySelectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    var viewModel: CurrencySelectionViewModel?
    var currencySelected: ((KeyValueRatio) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    private func setupInterface() {
        tableView.register(UINib(nibName: CurrencyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        addShadow(view: searchBar)
    }
}

// MARK: - UITableViewDelegate
extension CurrencySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCurrency = viewModel?.data?.keyValueRatios[indexPath.row] else { return }
        self.currencySelected?(selectedCurrency)
        
    }
}

// MARK: - UITableViewDataSource
extension CurrencySelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.data?.keyValueRatios.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell,
              let currency = self.viewModel?.data?.keyValueRatios[indexPath.row].key else { return UITableViewCell() }
        cell.setup(currency: currency, baseCurrency: viewModel?.baseCurrency)
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension CurrencySelectionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if let filteredData = self.viewModel?.filterData(char: updatedText, originalData: viewModel?.originalData) {
                self.viewModel?.data?.keyValueRatios = filteredData
            }
            tableView.reloadData()
            return true
        }
        return false
    }
}

