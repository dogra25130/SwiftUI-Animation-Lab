//
//  Shop.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import Foundation
class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}
