//
//  ContentView.swift
//  HorizontalScrollerTabs
//
//  Created by Abhishek Dogra on 25/02/24.
//

import SwiftUI

let tabs = ["Home", "Search"]
struct ContentView: View {
    @State var offset: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .global)
            ScrollableTabBar(tabs: tabs, rect: rect, offset: $offset) {
                HStack(spacing: 0) {
                    Color.red
                    Color.blue
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .overlay (
            TabBar(offset: $offset),
            alignment: .top
                
        )
    }
}

#Preview {
    ContentView()
}


