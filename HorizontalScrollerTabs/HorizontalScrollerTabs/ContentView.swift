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
            VStack {
                TabBar(offset: $offset)
                ScrollableTabBar(tabs: tabs, rect: rect, offset: $offset) {
                    HStack(spacing: 0) {
                        ScrollView {
                            VStack {
                                Text("A")
                                    .frame(width: 500, height: 500)
                                Text("A").frame(width: 500, height: 500)
                                Text("A").frame(width: 500, height: 500)
                                Text("A").frame(width: 500, height: 500)
                                Text("A").frame(width: 500, height: 500)
                                Text("A").frame(width: 500, height: 500)
                            }
                        }.frame(width: proxy.size.width, height: proxy.size.height)
                        ScrollView {
                            VStack {
                                Text("B").frame(width: 500, height: 500)
                                Text("B").frame(width: 500, height: 500)
                                Text("B").frame(width: 500, height: 500)
                                Text("B").frame(width: 500, height: 500)
                                Text("B").frame(width: 500, height: 500)
                            }
                        }.frame(width: proxy.size.width, height: proxy.size.height)
                    }
                    .ignoresSafeArea()
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}


