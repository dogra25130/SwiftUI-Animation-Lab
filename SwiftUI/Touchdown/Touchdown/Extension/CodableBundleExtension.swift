//
//  CodableBundleExtension.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError("failed to locate file") }
        guard let data = try? Data(contentsOf: url) else { fatalError("failed to load file from bundle") }
        let decoder = JSONDecoder()
        guard let deoodedData = try? decoder.decode(T.self, from: data) else { fatalError("failed to decode") }
        return deoodedData 
    }
}
