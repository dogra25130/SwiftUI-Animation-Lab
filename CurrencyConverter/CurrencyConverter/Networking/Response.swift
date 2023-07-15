//
//  Response.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let disclaimer: String
    let license: String
    let timestamp: TimeInterval
    let base: String
    let rates: [String: Double]
    
    init?(with data: Data) {
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ExchangeRateResponse.self, from: data)
        else { return nil }

        self = response
    }
    
    func getModel() -> ExchangeRateModel {
        let keyValueRatio = self.rates.map { response in
            return KeyValueRatio(key: response.key, value: response.value)
        }
        return ExchangeRateModel(disclaimer: disclaimer,
                                   license: license,
                                   timestamp: timestamp,
                                   base: base,
                                   keyValueRatios: keyValueRatio)
    }
}
