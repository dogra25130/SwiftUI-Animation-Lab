//
//  OTPViewModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import Foundation

class OTPViewModel: ObservableObject {
    @Published var otp: String = ""
    @Published var isLoading = false
    
    let phoneNumber: String
    let isRegistered: Bool
    let usecase: OTPUseCase
    
    init(phoneNumber: String, isRegistered: Bool, usecase: OTPUseCase = OTPService()) {
        self.phoneNumber = phoneNumber
        self.isRegistered = isRegistered
        self.usecase = usecase
    }
    
    func verifyOTP() {
        isLoading = true
        Task {
            let _ = try await usecase.verifyOTP(phone: phoneNumber, otp: otp)
            await MainActor.run {[weak self] in
                self?.isLoading = false
            }
        }
    }
}
