//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var swipeInfoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var baseCurrencyButton: UIButton!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()
    
    var viewModel: HomeViewModel?
    var timer: Timer? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupBindings()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    private func setupInterface() {
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        topContainer.backgroundColor =  UIColor(named: "backgroundAdaptiveColor")
        baseCurrencyButton.backgroundColor = UIColor(named: "buttonAdaptiveColor")
        
        amountField.becomeFirstResponder()
        amountField.placeholder = "Please enter the amount"
        
        searchBar.placeholder = "Search "
        tableView.accessibilityIdentifier = "tableView"
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.dataSource = self
        
        amountField.delegate = self
        searchBar.delegate = self
        addShadow(view: baseCurrencyButton)
        addShadow(view: amountField)
        addShadow(view: searchBar)
    }
    
    private func setupBindings() {
        loader.startAnimating()
        viewModel?.data.bind(listner: { [weak self] _ in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                self?.refreshControl.endRefreshing()
                self?.loaderView.isHidden = true
                self?.baseCurrencyButton.setTitle("\(self?.viewModel?.baseCurrency?.key ?? "") ▼", for: .normal)
                self?.showSwipeGesture()
                self?.tableView.reloadData()
            }
        })
        viewModel?.fetchData()
    }
    
    private func showSwipeGesture() {
        guard UserDefaults.standard.bool(forKey: refreshIndicatorShown) == false else { return }
        UserDefaults.standard.set(true, forKey: refreshIndicatorShown)
        swipeInfoViewHeightConstraint.constant = 40
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }completion: {[weak self] _ in
            self?.swipeInfoViewHeightConstraint.constant = 0
            UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.viewModel?.fetchData()
    }
    
    @IBAction private func baseCurrencyTapped(_ sender: Any) {
        let vc = CurrencySelectionViewController()
        vc.viewModel = CurrencySelectionViewModel(originalData: viewModel?.originalData,
                                                  searchUseCase: viewModel?.searchUseCase,
                                                  baseCurrency: viewModel?.baseCurrency)
        vc.currencySelected = { [weak self] selectedCurrency in
            
            self?.viewModel?.baseCurrency = selectedCurrency
            self?.baseCurrencyButton.setTitle("\(selectedCurrency.key) ▼", for: .normal)
            self?.tableView.reloadData()
            vc.dismiss(animated: true)
        }
        self.present(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.data.value?.keyValueRatios.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell,
              let currentCurrency = self.viewModel?.data.value?.keyValueRatios[indexPath.row],
              let amount = viewModel?.getAmount(currentCurrency: currentCurrency) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setup(currentCurrency: currentCurrency, amount: amount)
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == amountField {
                if let factor = Double(updatedText) {
                    self.viewModel?.multiplicationFactor = factor
                }else {
                    self.viewModel?.multiplicationFactor = updatedText.count > 0 ? -1.0 : 0.0
                }
            }else {
                if let filteredData = self.viewModel?.filterData(char: updatedText, originalData: viewModel?.originalData) {
                    self.viewModel?.data.value?.keyValueRatios = filteredData
                }
            }
            tableView.reloadData()
            return true
        }
        return false
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewController: HomeViewModelProtocol {
    func showNoInternetToast() {
        let alert = UIAlertController(title: "No internet", message: "Please check you internet and try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { [weak self] action in
            switch action.style {
            case .destructive:
                self?.viewModel?.fetchData()
            default:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
