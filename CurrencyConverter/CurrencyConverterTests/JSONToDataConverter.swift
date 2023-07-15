//
//  JSONToDataConverter.swift
//  CurrencyConverterTests
//
//  Created by Abhishek Dogra on 16/06/23.
//

import Foundation
class JSONToDataConverter {
    static func loadData(at path: String) -> Data? {
        guard let url = Bundle(for: JSONToDataConverter.self).url(forResource: path, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
}
