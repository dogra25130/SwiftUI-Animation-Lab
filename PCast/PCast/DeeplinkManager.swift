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
}

class Router: ObservableObject {
    @Published var navPath: NavigationPath = NavigationPath()
    @Published var shouldShowBackButton: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $navPath
            .sink { [weak self] path in
                withAnimation(.easeInOut) {
                    self?.shouldShowBackButton = !path.isEmpty
                }
            }
            .store(in: &cancellables)
    }
    
    func navigateTo(_ page: Deeplink) {
        withAnimation(.easeInOut) {
            navPath.append(page)
        }
    }
    
    func goBack() {
        withAnimation(.easeInOut) {
            if !navPath.isEmpty {
                navPath.removeLast()
            }
        }
    }
}
