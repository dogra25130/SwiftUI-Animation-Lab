//
//  CodableBundleExtension.swift
//  Africa
//
//  Created by Abhishek Dogra on 04/06/23.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode file from bundle")
        }
        
        return loaded
    }
}
