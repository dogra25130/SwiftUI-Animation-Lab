//
//  File.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation
protocol HomeUserCase {
    func getLatestRates(completion: @escaping (Result<ExchangeRateModel, APIError>) -> Void)
}
