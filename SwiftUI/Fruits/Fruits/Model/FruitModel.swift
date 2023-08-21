//
//  FruitModel.swift
//  Fruits
//
//  Created by Abhishek Dogra on 03/06/23.
//

import SwiftUI
struct Fruit: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var description: String
    var nutrition: [String]
}
