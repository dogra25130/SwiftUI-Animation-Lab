//
//  OTPModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation
struct OTPResponseModel: Codable {
    let phoneNumber: String
    let token: String
}
