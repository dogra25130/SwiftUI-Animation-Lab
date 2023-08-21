//
//  ProductModel.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import Foundation
struct Product: Codable, Identifiable {
    let id: Int
    let image: String
    let name: String
    let price: Int
    let description: String
    let color: [Double]
    
    var red: Double { return color[0] }
    var green: Double { return color[1] }
    var blue: Double { return color[2] }
    var formattedPrice: String { return "$\(price)" }
}
