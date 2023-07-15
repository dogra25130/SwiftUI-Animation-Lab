//
//  ExchangeRateManager.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//

import Foundation
struct ExchangeRateManager {
    private let exchangeRateRepository = ExchangeRateRepository()
    
    public func createExchangeRateModel(record: ExchangeRateModel) {
        exchangeRateRepository.create(record: record)
    }

    func getExchangeRateModel() -> ExchangeRateModel? {
        return exchangeRateRepository.get(byIdentifier: universalID)
    }
    
    func updateExchangeRateModel(record: ExchangeRateModel) -> Bool {
        return exchangeRateRepository.update(record: record)
    }
}
