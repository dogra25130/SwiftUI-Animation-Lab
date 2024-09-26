//
//  HomeView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

enum HomeViewRoutes: Hashable {
    case red
}

class HomeViewCoordinator {
    func navigateTo(route: HomeViewRoutes) -> some View {
        switch route {
        case .red: Color.red
        }
    }
}

struct HomeView: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = HomeViewModel()
    let homeViewCoordinator = HomeViewCoordinator()
    @State private var isLoading = true
    
    var body: some View {
        ContentView
            .opacity(viewModel.homeDataModel.isNil ? 0 : 1)
            .applyHomeShimmerView(isLoading: viewModel.homeDataModel.isNil)
            .ignoresSafeArea()
            .onAppear { viewModel.fetchData() }
            .navigationDestination(for: HomeViewRoutes.self) { route in
                homeViewCoordinator.navigateTo(route: route)
            }
    }
}

extension HomeView {
    var ContentView: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: .zero) {
                SuggestedPodCastView
                PodCastView
                Divider()
                AuthorView
                    .onTapGesture {
                        coordinator.navPath.append(Deeplink.browse)
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
