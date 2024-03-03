//
//  SwiftUINavigationApp.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

@main
struct SwiftUINavigationApp: App {
    @StateObject private var deeplinkRouter = DeeplinkRouter()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $deeplinkRouter.navPath) {
                TabsView()
                    .onOpenURL { url in
                        Task {
                            deeplinkRouter.push(to: .secondScreen)
                        }
                    }
            }
            .navigationDestination(for: Deeplink.self) { $0 }
        }
    }
}
