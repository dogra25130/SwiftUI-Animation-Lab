//
//  ExchangeRateEntityExtension.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//

import Foundation

extension ExchangeRateEntity {
    func convertToExchangeRateModel() -> ExchangeRateModel {
        let kvRatios = keyValueEntity?.map { $0.convertToKeyValueRatioModel() }
        return ExchangeRateModel(disclaimer: self.description,
                                 license: license ?? "",
                                 timestamp: timestamp,
                                 base: base ?? "",
                                 keyValueRatios: kvRatios ?? [])
    }
}
