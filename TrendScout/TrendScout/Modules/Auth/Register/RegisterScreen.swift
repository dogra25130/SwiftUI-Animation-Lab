//
//  RegisterScreen.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 19/07/24.
//

import SwiftUI

struct RegisterScreen: View {
    private enum HighlightedView {
        case inputField
        case continueButton
        case none
    }
    private struct Constants {
        static let title = "Verify Email Address"
        static let subtitle = "Enter your email for better communication"
        static let placeholder = "Email Address"
        static let `continue` = "Continue"
        static let disableButtonOpacity = 0.5
    }
    @EnvironmentObject private var appRootManager: AppRootManager
    @State private var highlightedView: HighlightedView = .none
    @StateObject var viewModel: RegisterViewModel
    @FocusState var isTextFieldFocused: Bool
    @Binding var navPath: NavigationPath
    
    init(navPath: Binding<NavigationPath>, viewModel: RegisterViewModel) {
        _navPath = navPath
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: .p20) {
                Text(Constants.title)
                    .font(.title)
                Text(Constants.subtitle)
                InputField
                Spacer()
                ContinueButton
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navPath.removeLast()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .onAppear {
            isTextFieldFocused = false
        }
        .onChange(of: isTextFieldFocused) { _, newValue in
            withAnimation {
                if newValue {
                    if viewModel.isEmailValid {
                        highlightedView = .continueButton
                    } else {
                        highlightedView = .inputField
                    }
                } else {
                    if viewModel.isEmailValid {
                        highlightedView = .continueButton
                    } else {
                        highlightedView = .none
                    }
                }
            }
        }
        .onChange(of: viewModel.isEmailValid) { _, newValue in
            withAnimation {
                if newValue {
                    highlightedView = .continueButton
                } else {
                    if isTextFieldFocused {
                        highlightedView = .inputField
                    } else {
                        highlightedView = .none
                    }
                }
            }
        }
        .onChange(of: viewModel.isLoading) { _, newValue in
            if !newValue {
                appRootManager.currentRoot = .home
            }
        }
    }
}

extension RegisterScreen {
    var InputField: some View {
        HStack {
            TextField("",
                      text: $viewModel.email,
                      prompt: Text(Constants.placeholder)
                .foregroundColor(.gray)
            )
            .keyboardType(.emailAddress)
            .focused($isTextFieldFocused)
            .bold()
        }
        .padding()
        .foregroundColor(.white)
        .background {
            RoundedRectangle(cornerRadius: .p24)
                .fill(Color.black)
                .shadow(color: .white.opacity(highlightedView == .inputField ? 1 : 0),
                        radius:  highlightedView == .inputField ? .r4 : 0)
        }
        .overlay {
            RoundedRectangle(cornerRadius: .p24, style: .continuous)
                .stroke(highlightedView == .inputField ? .white : .gray)
                .shadow(color: .white, radius: highlightedView == .inputField ? .r4 : .zero)
        }
        .overlay {
            RoundedRectangle(cornerRadius: .p24, style: .continuous)
                .stroke(highlightedView == .inputField ? .white : .gray)
                .shadow(color: .white, radius: highlightedView == .inputField ? .r4 : .zero)
        }
    }
    
    var ContinueButton: some View {
        Button {
            viewModel.registerUser()
        } label: {
            ButtonWithLoaderView(isLoading: $viewModel.isLoading, label: Constants.continue)
            
        }
        .disabled(!viewModel.isEmailValid)
        .background(Color.black)
        .cornerRadius(.p24)
        .shadow(color: .white, radius: highlightedView == .continueButton ? .r4 : .zero)
        .overlay {
            RoundedRectangle(cornerRadius: .p24)
                .fill(Color.black)
                .opacity(highlightedView == .continueButton ? .zero : Constants.disableButtonOpacity)
        }
        .overlay {
            RoundedRectangle(cornerRadius: .p24, style: .continuous)
                .stroke(highlightedView == .continueButton ? .white : .gray)
                .shadow(color: .white, radius: highlightedView == .continueButton ? .r4 : .zero)
        }
    }
}



