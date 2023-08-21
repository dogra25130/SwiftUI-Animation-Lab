//
//  Constants.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 07/06/23.
//

import SwiftUI
let players: [Player] = Bundle.main.decode("player.json")
let colorBackground: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.gray)
let categories: [Category] = Bundle.main.decode("category.json")
let products: [Product] = Bundle.main.decode("product.json")
let brands: [Brand] = Bundle.main.decode("brand.json")
let sampleProduct: Product = products[0]

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}
