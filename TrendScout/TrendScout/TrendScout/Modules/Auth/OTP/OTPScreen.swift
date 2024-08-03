//
//  OTPViewController.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 17/07/24.
//

import SwiftUI

struct OTPScreen: View {
    private enum NavigationDestinations: Hashable {
        case register
    }
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @Binding var navPath: NavigationPath
    @StateObject var viewModel: OTPViewModel
    
    init(navPath: Binding<NavigationPath>, viewModel: OTPViewModel) {
        _navPath = navPath
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ZStack {
                VStack(alignment: .leading, spacing: .p20) {
                    Text("Verification Code")
                        .font(.title)
                    Text("We have sent verification code to \n")
                    +
                    Text(viewModel.phoneNumber)
                        .bold()
                    
                    OTPFieldView(activeIndicatorColor: .white,
                                 inactiveIndicatorColor: .gray,
                                 length: 4) { otp in
                        viewModel.verifyOTP()
                    }
                    Spacer()
                }
                .padding(.top)
                
                if viewModel.isLoading {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    CircularLoaderView(frame: CGSize(width: .p20, height: .p20))
                        .padding(.p32)
                        .background(
                            RoundedRectangle(cornerRadius: .p10, style: .continuous)
                                .stroke(.white)
                                .shadow(color: .white, radius: .r4)
                        )
                        
                        
                }
            }
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
        .navigationDestination(for: NavigationDestinations.self) { destination in
            switch destination {
            case .register:
                RegisterScreen(navPath: $navPath, viewModel: RegisterViewModel(phoneNumber: viewModel.phoneNumber))
            }
        }
        .onChange(of: viewModel.isLoading) { _, value in
            if !value {
                if viewModel.isRegistered {
                    navPath.append(NavigationDestinations.register)
                } else {
                    appRootManager.currentRoot = .home
                }
            }
        }
    }
}
