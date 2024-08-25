//
//  LoginView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authState: UserAuthState
    @StateObject private var viewModel = LoginViewModel()
    
    private struct Constants {
        static let title = "Episodic series of \n digital audio."
    }
    
    private struct LoginButton {
        static let title = "Login"
        static let color = Color(hex: "3369FF")
    }
    
    private struct LoginWithFB {
        static let title = "Login with Facebook"
        static let color = Color(hex: "2B5D95")
    }
    
    private struct RegisterButton {
        static let title = "Register"
        static let color = Color.red
    }
    
    private struct ForgotPasswordButton {
        static let title = "Forgot password"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            LogoView()
            Spacer()
            Text(Constants.title).font(.setFont(.medium500, 24))
                .fixedSize()
            Spacer()
            VStack(spacing: 16) {
                PTextField(textFieldType: .email)
                PTextField(textFieldType: .password)
                    .padding(.bottom, 16)
                
                PButton(title: LoginButton.title,
                        color: LoginButton.color,
                        isLoading: $viewModel.isLoginLoading) {
                    viewModel.loginUser()
                }
                .shadow(color: LoginButton.color, radius: 10)
                PButtonUnderline(text: ForgotPasswordButton.title) {
                    viewModel.loginUser()
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 16)
            
            VStack(spacing: 16) {
                PButton(title: LoginWithFB.title,
                        color: LoginWithFB.color,
                        isLoading: $viewModel.isLoginWithFBLoading) {
                    viewModel.loginUser()
                }
                
                PButton(title: RegisterButton.title,
                        color: RegisterButton.color,
                        isLoading: $viewModel.isRegisterLoading) {
                    viewModel.loginUser()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
        .disabled(viewModel.isLoading)
        .onChange(of: viewModel.authSuccessful) { _, newValue in
            if newValue {
                authState.currentState = .authorised
            }
        }
    }
}

#Preview {
    LoginView()
}
