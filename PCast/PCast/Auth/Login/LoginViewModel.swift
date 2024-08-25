//
//  LoginViewModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoginLoading = false
    @Published var isLoginWithFBLoading = false
    @Published var isRegisterLoading = false
    @Published var authSuccessful = false
    @Published var isLoading = false {
        didSet {
            if !isLoading {
                isLoginLoading = false
                isLoginWithFBLoading = false
                isRegisterLoading = false
            }
        }
    }
    
    var responseModel: LoginResponseModel?
    private let usecase: LoginUseCase
    
    init(service: LoginUseCase = LoginService()) {
        usecase = service
        setObservers()
    }
    
    func setObservers() {
        isScreenLoading
            .receive(on: DispatchQueue.main)
            .assign(to: &$isLoading)
    }
    
    func authenticationSuccessful() {
        authSuccessful = true
    }
    
    func loginUser() {
        guard !isLoading else { return }
        Task {
            do {
                let responseModel = try await usecase.verify(with: LoginModel(email: email))
                self.responseModel = responseModel
                isLoading = false
                authenticationSuccessful()
            } catch {
                isLoading = false
            }
        }
    }
    
    private func resetLoadingStates() {
        isLoginLoading = false
        isLoginWithFBLoading = false
        isRegisterLoading = false
    }
}

extension LoginViewModel {
    private var isScreenLoading: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($isLoginLoading, $isLoginWithFBLoading, $isRegisterLoading)
            .map { loginLoading, fbLoading, registerLoading in
                loginLoading || fbLoading || registerLoading
            }
            .eraseToAnyPublisher()
    }
}
