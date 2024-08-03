//
//  RegisterService.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation
protocol RegisterUseCase: AnyObject {
    func registerUser(phone: String, email: String) async throws -> RegisterResponseModel
}

class RegisterService: RegisterUseCase {
    private let networkManager = NetworkManager()

    func registerUser(phone: String, email: String) async throws -> RegisterResponseModel {

        try await Task.sleep(nanoseconds: 500_000_000)
        return RegisterResponseModel(phoneNumber: phone,
                                     token: UUID().uuidString,
                                     email: email)

    }
}
