//
//  ContentView.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            FirstCoordinatorView()
                .tabItem { Label("First", systemImage: "doc.text.magnifyingglass") }
            SecondCoordinatorView()
                .tabItem { Label("Second", systemImage: "star.fill") }
        }
    }
}

#Preview {
    TabsView()
}
