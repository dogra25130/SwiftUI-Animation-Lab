//
//  LoginViewModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 17/07/24.
//

import Combine
import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var isPhoneValid = false
    @Published var isLoading = false
    var responseModel: LoginResponseModel?
    let backgroundImages = ["l1", "l2", "l3", "l4"]
    let maxPhoneNumberLimit = 10
    
    private var publishers = Set<AnyCancellable>()
    private let usecase: LoginUseCase
    
    init(service: LoginUseCase = LoginService()) {
        usecase = service
        setupObservers()
    }
    
    private func setupObservers() {
        isPhoneNumberValid
              .receive(on: RunLoop.main)
              .assign(to: \.isPhoneValid, on: self)
              .store(in: &publishers)
    }
    
    func sendOTP() {
        isLoading = true
        Task {
            do {
                let responseModel = try await usecase.sendOTP(with: LoginModel(phoneNumber: phoneNumber))
                self.responseModel = responseModel
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }

}

extension LoginViewModel {
    private var isPhoneNumberValid: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { phone in
                return phone.count == self.maxPhoneNumberLimit
            }
            .eraseToAnyPublisher()
    }
}
