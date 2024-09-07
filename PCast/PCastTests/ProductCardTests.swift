//
//  ProductCardTests.swift
//  PCastTests
//
//  Created by Abhishek Dogra on 07/09/24.
//

import XCTest
import SnapshotTesting
@testable import PCast

final class ProductCardTests: XCTestCase {

    func testProductCardVariant() throws {
        let model: PodCastModel = loadJSON(for: "ProductCardMockResponse")
        let view = PodCastCard(model: model)
        assertSnapshot(of: view, as: .image)
    }
    
    func loadJSON<T: Decodable>(for fileName: String) -> T {
        let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
