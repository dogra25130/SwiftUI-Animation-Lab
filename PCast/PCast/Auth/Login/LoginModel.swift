//
//  LoginModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Foundation
struct LoginModel: Codable {
    let email: String
}

struct LoginResponseModel: Codable {
    let email: String
    let isRegistered: Bool
}
