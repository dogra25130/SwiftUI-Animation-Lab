//
//  HomeView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.safeAreaInsets) var safeAreaInsets
    @EnvironmentObject var deeplinkManager: DeeplinkManager
    @StateObject var viewModel = HomeViewModel()
    @State private var isLoading = true
    
    var body: some View {
        ContentView
            .opacity(viewModel.homeDataModel.isNil ? 0 : 1)
            .applyHomeShimmerView(isLoading: viewModel.homeDataModel.isNil)
            .ignoresSafeArea()
            .onAppear { viewModel.fetchData() }
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
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
