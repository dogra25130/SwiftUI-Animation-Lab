//
//  CurrencyConverterUseCase.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
protocol CurrencyConverterUseCase {
    func getAmount(baseCurrency: KeyValueRatio?, currentCurrency: KeyValueRatio, factor: Double) -> String
}
