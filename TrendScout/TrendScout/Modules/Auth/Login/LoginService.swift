//
//  LoginService.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 19/07/24.
//

import Foundation

protocol LoginUseCase: AnyObject {
    func sendOTP(with model: LoginModel) async throws -> LoginResponseModel
}

class LoginService: LoginUseCase {
    private let networkManager = NetworkManager()

    func sendOTP(with model: LoginModel) async throws -> LoginResponseModel {
//        let params = ["phone": phone.phoneNumber]
//        if let data = try await networkManager.makeAPIRequest(url: .sendOTP, method: .post, params: params) {
//            let model = try JSONDecoder().decode(LoginResponseModel.self, from: data)
//            return model
//        } else {
//            throw NetworkError(message: .invalidResponse)
//        }
        try await Task.sleep(nanoseconds: 500_000_000)
        return LoginResponseModel(phoneNumber: model.phoneNumber,
                                  isRegistered: model.phoneNumber == "8486802418")

    }
}

