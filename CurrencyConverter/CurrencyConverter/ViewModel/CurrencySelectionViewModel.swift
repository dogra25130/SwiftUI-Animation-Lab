//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
class CurrencySelectionViewModel {
    var data: ExchangeRateModel?
    let originalData: ExchangeRateModel?
    let searchUseCase: SearchUseCase?
    let baseCurrency: KeyValueRatio?
    init(originalData: ExchangeRateModel?, searchUseCase: SearchUseCase?, baseCurrency: KeyValueRatio?) {
        self.data = originalData
        self.originalData = originalData
        self.searchUseCase = searchUseCase
        self.baseCurrency = baseCurrency
    }
    
    func filterData(char: String, originalData: ExchangeRateModel?) -> [KeyValueRatio] {
        return searchUseCase?.filterData(char: char, originalData: originalData) ?? []
    }
}
