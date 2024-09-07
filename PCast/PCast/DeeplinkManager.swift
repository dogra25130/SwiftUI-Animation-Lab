//
//  DeeplinkManager.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import Combine
import SwiftUI

enum Deeplink: Hashable {
    case podcast(PodCastModel)
    case browse
}

class DeeplinkManager: ObservableObject {
    
    static let shared = DeeplinkManager()
    @Published var navPath: NavigationPath = NavigationPath()
    @Published var shouldShowBackButton: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        $navPath
            .sink { [weak self] path in
                withAnimation(.easeInOut) {
                    self?.shouldShowBackButton = !path.isEmpty
                }
            }
            .store(in: &cancellables)
    }
    
    func navigateTo(_ page: Deeplink, shouldAnimate: Bool = true) {
//        withAnimation(shouldAnimate ? .easeInOut : .none) {
            navPath.append(page)
//        }
    }
    
    func goBack() {
        withAnimation(.easeInOut) {
            if !navPath.isEmpty {
                navPath.removeLast()
            }
        }
    }
}
