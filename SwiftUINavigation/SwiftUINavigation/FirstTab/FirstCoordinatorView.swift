//
//  FirstCoordinatorView.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

struct FirstCoordinatorView: View {
    @ObservedObject var router = FirstCoordinator()
    var body: some View {
        NavigationStack(path: $router.navPath) {
            FirstHomeView(router: router)
                .navigationDestination(for: FirstCoordinator.Destination.self) { destination in
                    switch destination {
                    case .livingRoom:
                        Text("Living Room")
                    case .bedroom(let owner):
                        Text("Bedroom for \(owner)")
                    }
                }
        }
    }
}

#Preview {
    FirstCoordinatorView()
}
