//
//  SecondCoordinatorView.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

struct SecondCoordinatorView: View {
    @ObservedObject var router = SecondCoordinator()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            SecondHomeView()
                .navigationDestination(for: SecondCoordinator.Destination.self) { destination in
                    switch destination {
                    case .livingRoom:
                        Text("Living Room2")
                    case .bedroom(let owner):
                        Text("Bedroom for \(owner)2")
                    }
                }
        }
    }
}


#Preview {
    SecondCoordinatorView()
}
