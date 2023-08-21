//
//  CategoryModel.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import Foundation
struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
