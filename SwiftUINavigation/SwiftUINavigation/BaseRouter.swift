//
//  BaseRouter.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

class BaseRouter: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
