//
//  Search.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
class SearchManager: SearchUseCase {
    func filterData(char: String, originalData: ExchangeRateModel?) -> [KeyValueRatio] {
        guard let originalData = originalData else { return [] }
        if(char.count == 0){
            return originalData.keyValueRatios
        }else {
            return originalData.keyValueRatios.filter({ $0.key.contains(char.uppercased()) })
        }
    }
}
