//
//  RegisterViewModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 19/07/24.
//

import Combine
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    @Published var isLoading: Bool = false
    private var publishers = Set<AnyCancellable>()
    private let usercase: RegisterUseCase
    let phoneNumber: String
    
    init(phoneNumber: String, usercase: RegisterUseCase = RegisterService()) {
        self.phoneNumber = phoneNumber
        self.usercase = usercase
        bind()
    }
    
    private func bind() {
        isEmailValidPublisher
              .receive(on: RunLoop.main)
              .assign(to: \.isEmailValid, on: self)
              .store(in: &publishers)
    }
    
    func registerUser() {
        isLoading = true
        Task {
            let _ = try await usercase.registerUser(phone: phoneNumber, email: email)
            await MainActor.run { [weak self] in
                self?.isLoading = false
            }
        }
    }
}

extension RegisterViewModel {
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
}
