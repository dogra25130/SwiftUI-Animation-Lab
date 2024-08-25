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
    @StateObject var router = Router()
    @StateObject var searchViewModel = SearchViewModel()
    @State var topBarButton: TopBarButton = .none
    @State var searchScrollViewContentSize: CGSize = .zero
    @FocusState var isSearchFocused: Bool
    
    var body: some View {
        VStack(spacing: .zero) {
            NavigationStack(path: $router.navPath) {
                Group {
                    switch authState.currentState {
                    case .unauthorised:
                        LoginView()
                    case .authorised:
                        HomeView()
                    }
                }
                .environmentObject(authState)
                .environmentObject(router)
                .preferredColorScheme(.dark)
                .navigationDestination(for: Deeplink.self) { value in Destination(for: value) }
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
    func Destination(for value: Deeplink) -> some View {
        switch value {
        case .podcast(let model):
            let viewModel = PodCastViewModel(model: model)
            return PodcastPlayer(viewModel: viewModel)
        }
    }
    
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
}
