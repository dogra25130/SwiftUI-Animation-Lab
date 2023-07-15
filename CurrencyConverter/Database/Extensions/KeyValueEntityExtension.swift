//
//  KeyValueEntityExtension.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//

import Foundation
extension KeyValueEntity {
    func convertToKeyValueRatioModel() -> KeyValueRatio {
        return KeyValueRatio(key: self.key ?? "", value: self.value)
    }
}
