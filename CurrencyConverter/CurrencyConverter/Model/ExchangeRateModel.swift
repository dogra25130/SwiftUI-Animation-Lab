//
//  ConversionRateModel.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//
//
import Foundation
struct ExchangeRateModel {
    let id: UUID = universalID
    let disclaimer: String
    let license: String
    let timestamp: TimeInterval
    let base: String
    var keyValueRatios: [KeyValueRatio]
}

struct KeyValueRatio: Hashable {
    let key: String
    let value: Double
}

