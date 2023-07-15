//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation
protocol HomeViewModelProtocol: AnyObject {
    func showNoInternetToast()
}

class HomeViewModel {
    let networkUseCase: HomeUserCase
    let searchUseCase: SearchUseCase
    let currencyConverterUseCase: CurrencyConverterUseCase
    var data: Observable<ExchangeRateModel> = Observable(value: nil)
    var originalData: ExchangeRateModel?
    var baseCurrency: KeyValueRatio?
    let databaseManager: ExchangeRateManager = ExchangeRateManager()
    var multiplicationFactor: Double = 0.0
    weak var delegate: HomeViewModelProtocol?
    init(networkUseCase: HomeUserCase,
         searchUseCase: SearchUseCase,
         currencyConverterUseCase: CurrencyConverterUseCase,
         delegate: HomeViewModelProtocol) {
        self.networkUseCase = networkUseCase
        self.searchUseCase = searchUseCase
        self.currencyConverterUseCase = currencyConverterUseCase
        self.delegate = delegate
    }
    
    func fetchData() {
        let canFetchFromServer: Bool = UserDefaults.standard.integer(forKey: cooldownTimeKey) <= Int(Date().timeIntervalSince1970)
        if canFetchFromServer == false, let model = databaseManager.getExchangeRateModel() {
            self.setupInteralData(model: model)
        }else {
            guard Reachability.isConnectedToNetwork() else {
                self.delegate?.showNoInternetToast()
                return
            }
            self.networkUseCase.getLatestRates { result in
                switch result {
                case .success(let model):
                    self.setupInteralData(model: model)
                    self.saveModelToDatabase(model: model)
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func setupInteralData(model: ExchangeRateModel) {
        UserDefaults.standard.set(Date().timeIntervalSince1970 + cooldownTimePeriod, forKey: cooldownTimeKey)
        self.data.value = model
        self.data.value?.keyValueRatios.sort{ $0.key < $1.key }
        self.baseCurrency = self.data.value?.keyValueRatios.filter({ $0.key == "USD" }).first
        self.originalData = self.data.value
    }
    
    func saveModelToDatabase(model: ExchangeRateModel) {
        if self.databaseManager.updateExchangeRateModel(record: model) == false {
            self.databaseManager.createExchangeRateModel(record: model)
        }
    }
    
    func getAmount(currentCurrency: KeyValueRatio) -> String {
        self.currencyConverterUseCase.getAmount(baseCurrency: baseCurrency, currentCurrency: currentCurrency, factor: multiplicationFactor)
    }
    
    func filterData(char: String, originalData: ExchangeRateModel?) -> [KeyValueRatio] {
        return searchUseCase.filterData(char: char, originalData: originalData)
    }
}
