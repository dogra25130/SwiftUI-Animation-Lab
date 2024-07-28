//
//  ContentView.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 14/07/24.
//

import SwiftUI
import Lottie
import Combine

struct LoginScreen: View {
    private enum NavigationDestinations: Hashable {
        case otp
    }
    
    private enum HighlightedView {
        case inputField
        case continueButton
        case none
    }
    
    struct Constants {
        static let backgroundLayerOpacity = 0.4
        static let backgroundLayerRatio = 2.75
        static let disableButtonOpacity = 0.5
        static let SkipButtonText = "Skip"
        static let titleText = "TRENDSCOUT"
        static let desc = "Ride the wave of the latest trends with our curated collection of stylish and innovative products."
        static let phoneNumber = "Phone number"
        static let continueButtonText = "Login or Register"
        static let phoneNumberCode = "+91"
    }
    @EnvironmentObject private var appRootManager: AppRootManager
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var shouldShowShadowLayer = false
    @State private var highlightedView: HighlightedView = .none
    @State var navPath = NavigationPath()
    @State var isButtonLoading: Bool = false
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                BackgroundView
                VStack(alignment: .leading, spacing: .p16) {
                    SkipButton
                    Spacer()
                    InfoView
                    UserInputView
                }
                .padding()
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        shouldShowShadowLayer = true
                    }
                }
            }
            .navigationDestination(for: NavigationDestinations.self) { destination in
                switch destination {
                case .otp:
                    let viewModel = OTPViewModel(phoneNumber: viewModel.responseModel?.phoneNumber ?? "",
                                                 isRegistered: viewModel.responseModel?.isRegistered ?? false)
                    OTPScreen(navPath: $navPath, viewModel: viewModel)
                }
            }
            .onChange(of: viewModel.isLoading){ _, newValue in
                if newValue == false {
                    navigateTo(.otp)
                }
            }
            .onChange(of: isTextFieldFocused) { _, newValue in
                withAnimation {
                    if newValue {
                        if viewModel.isPhoneValid {
                            highlightedView = .continueButton
                        } else {
                            highlightedView = .inputField
                        }
                    } else {
                        if viewModel.isPhoneValid {
                            highlightedView = .continueButton
                        } else {
                            highlightedView = .none
                        }
                    }
                }
            }
            .onChange(of: viewModel.isPhoneValid) { _, newValue in
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
        }
    }
}

extension LoginScreen {
    var BackgroundView: some View {
        ZStack {
            Color.black
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: .zero) {
                        ForEach(viewModel.backgroundImages, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .frame(width: proxy.size.width)
                                .blur(radius: shouldShowShadowLayer ? .zero : .p4)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                if shouldShowShadowLayer {
                    HStack {
                        Rectangle()
                            .frame(width: proxy.size.width / Constants.backgroundLayerRatio)
                            .foregroundStyle(Color.black.opacity(Constants.backgroundLayerOpacity))
                        Spacer()
                    }
                    .transition(.slide)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    var SkipButton: some View {
        HStack {
            Spacer()
            Button {
                appRootManager.currentRoot = .home
            } label: {
                Text(Constants.SkipButtonText)
                    .font(.system(size: .p14))
                    .padding(EdgeInsets(top: .p12, leading: .p16, bottom: .p12, trailing: .p16))
                    .foregroundColor(.white)
            }
            .background(Color.black)
            .cornerRadius(.p24)
        }
    }
    
    var InfoView: some View {
        VStack(alignment: .leading) {
            Text(Constants.titleText)
                .font(.largeTitle)
                .foregroundStyle(Color.white)
                .bold()
            
            Text(Constants.desc)
                .font(.footnote)
                .foregroundStyle(Color.white)
        }
    }
    
    var UserInputView: some View {
        VStack {
            HStack {
                Text(Constants.phoneNumberCode)
                    .bold()
                    .foregroundColor(.white)
                
                TextField("",
                          text: $viewModel.phoneNumber,
                          prompt: Text(Constants.phoneNumber)
                    .foregroundColor(.gray)
                )
                .onChange(of: viewModel.phoneNumber) { _, _ in
                    viewModel.phoneNumber = String(viewModel.phoneNumber.prefix(viewModel.maxPhoneNumberLimit))
                }
                .keyboardType(.numberPad)
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
            
            Button {
                viewModel.sendOTP()
            } label: {
                ButtonWithLoaderView(isLoading: $viewModel.isLoading, label: Constants.continueButtonText)
            }
            .disabled(!viewModel.isPhoneValid)
            .background(Color.black)
            .cornerRadius(.p24)
            .shadow(color: .white, radius: highlightedView == .continueButton ? .r4 : .zero)
            .overlay {
                RoundedRectangle(cornerRadius: .p24)
                    .fill(Color.black)
                    .opacity(viewModel.isPhoneValid ? .zero : Constants.disableButtonOpacity)
            }
            .overlay {
                RoundedRectangle(cornerRadius: .p24, style: .continuous)
                    .stroke(highlightedView == .continueButton ? .white : .gray)
                    .shadow(color: .white, radius: highlightedView == .continueButton ? .r4 : .zero)
            }
        }
    }
}

extension LoginScreen {
    private func navigateTo(_ screen: NavigationDestinations) {
        navPath.append(screen)
    }
}

#Preview {
    LoginScreen()
}
