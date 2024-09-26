//
//  PCastAppView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI

public enum AuthState {
    case unauthorised
    case authorised
}

class UserAuthState: ObservableObject {
    @Published var currentState: AuthState = .unauthorised
}

struct PCastAppView: View {
    enum TopBarButton {
        case search
        case profile
        case none
    }
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @StateObject var authState = UserAuthState()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var coordinator = Coordinator.shared
    @State var topBarButton: TopBarButton = .none
    @State var searchScrollViewContentSize: CGSize = .zero
    @FocusState var isSearchFocused: Bool
    var body: some View {
        VStack(spacing: .zero) {
            NavigationStack(path: $coordinator.navPath) {
                Group {
                    switch authState.currentState {
                    case .unauthorised:
                        LoginView()
                    case .authorised:
                        HomeView()
                    }
                }
                .background(Color(hex: "091228"))
                .environmentObject(authState)
                .environmentObject(coordinator)
                .preferredColorScheme(.dark)
                .navigationDestination(for: Deeplink.self) { value in coordinator.Destination(for: value) }
            }
        }
        .overlay { OverlayView }
        .overlay {
            if authState.currentState == .authorised {
                VStack {
                    TopBarView
                    Spacer()
                }
            }
        }
    }
}

extension PCastAppView {
    
    @ViewBuilder
    var OverlayView: some View {
        switch topBarButton {
        case .search:
            SearchView
        case .profile:
            ProfileView
        case .none:
            EmptyView()
        }
    }
    
    func setProfileState(_ state: TopBarButton, completion: (() -> Void)? = nil) {
        withAnimation { topBarButton = state } completion: { completion?() }
    }
}

#Preview(body: {
    PCastAppView()
})
