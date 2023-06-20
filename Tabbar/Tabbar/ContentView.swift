//
//  ContentView.swift
//  Tabbar
//
//  Created by Abhishek Dogra on 20/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Tab = .home

    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                ForEach(Tab.allCases, id: \.self) { channel in
                    Text(channel.rawValue)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                }
            }
            TabBar(currentTab: $currentTab)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum Tab: String, CaseIterable {
    static var allCases: [Tab] = [.home, .todo, .location, .map]
    case home = "home"
    case todo = "todo"
    case location = "location"
    case map = "map"
}
