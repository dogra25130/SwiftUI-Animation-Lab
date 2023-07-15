//
//  CurrencyConverterManager.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
class CurrencyConverterManager: CurrencyConverterUseCase {
    func getAmount(baseCurrency: KeyValueRatio?, currentCurrency: KeyValueRatio, factor: Double) -> String {
        guard let value = baseCurrency?.value, value > 0.0 else { return "NA" }
        let multiplicationFactor = factor / value
        
        if multiplicationFactor < 0 {
            return "NA"
        }else if multiplicationFactor == 0 {
            return "0.00000"
        }else {
            return String(describing: (currentCurrency.value * multiplicationFactor).truncate(places: 5) )
        }
    }
    
}
