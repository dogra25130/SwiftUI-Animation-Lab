//
//  RegisterModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation
struct RegisterResponseModel: Codable {
    let phoneNumber: String
    let token: String
    let email: String
}
