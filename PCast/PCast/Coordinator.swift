//
//  Coordinator.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/09/24.
//

import SwiftUI

class Coordinator: ObservableObject {
    @MainActor static let shared = Coordinator()
    @Published var navPath = NavigationPath()
    @Published var shouldShowBackButton = false
    
    private init() {}
    
    func navigateTo(_ page: Deeplink, shouldAnimate: Bool = true) {
        withAnimation(shouldAnimate ? .easeInOut : .none) {
            navPath.append(page)
            shouldShowBackButton = true
        }
    }
    
    func goBack() {
        withAnimation(.easeInOut) {
            if !navPath.isEmpty {
                navPath.removeLast()
            }
            shouldShowBackButton = !(navPath.isEmpty)
        }
    }
    
    @MainActor
    func Destination(for value: Deeplink) -> some View {
        Group {
            switch value {
            case .podcast(let model):
                PodcastPlayer(viewModel: PodCastViewModel(model: model))
            case .browse:
                BrowseView()
            case .Reels:
                ReelsView()
            }
        }
        .toolbar(.hidden, for: .automatic)
    }
}
