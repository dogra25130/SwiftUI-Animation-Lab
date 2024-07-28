//
//  TrendScout.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 14/07/24.
//

import SwiftUI

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: eAppRoots = .authentication
    enum eAppRoots {
        case authentication
        case home
    }
}

@main
struct TrendScout: App {
    @StateObject private var appRootManager = AppRootManager()
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .authentication:
                    LoginScreen()
                    
                case .home:
                    HomeScreen()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
