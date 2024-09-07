//
//  LoginService.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Foundation
protocol LoginUseCase: AnyObject {
    func verify(with model: LoginModel) async throws -> LoginResponseModel
}

class LoginService: LoginUseCase {
    private let networkManager = NetworkManager()

    func verify(with model: LoginModel) async throws -> LoginResponseModel {
        try await Task.sleep(nanoseconds: 500_000_000)
        return LoginResponseModel(email: model.email,
                                  isRegistered: model.email == "abc@gmail.com")

    }
}
