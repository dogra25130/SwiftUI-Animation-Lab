//
//  SearchUseCase.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
protocol SearchUseCase {
    func filterData(char: String, originalData: ExchangeRateModel?) -> [KeyValueRatio]
}
