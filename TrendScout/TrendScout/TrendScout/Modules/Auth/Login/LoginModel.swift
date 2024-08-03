//
//  LoginModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation
struct LoginModel: Codable {
    let phoneNumber: String
}

struct LoginResponseModel: Codable {
    let phoneNumber: String
    let isRegistered: Bool
}
