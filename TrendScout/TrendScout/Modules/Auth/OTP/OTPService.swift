//
//  OTPService.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation
protocol OTPUseCase: AnyObject {
    func verifyOTP(phone: String, otp: String) async throws -> OTPResponseModel
}

class OTPService: OTPUseCase {
    private let networkManager = NetworkManager()

    func verifyOTP(phone: String, otp: String) async throws -> OTPResponseModel {

        try await Task.sleep(nanoseconds: 500_000_000)
        return OTPResponseModel(phoneNumber: phone,
                                token: UUID().uuidString)

    }
}
