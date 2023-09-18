//
//  MainView.swift
//  Socius
//
//  Created by Abhishek Dogra on 16/09/23.
//

import SwiftUI

struct MainView: View {
    @State var currentTab: String = "Photos"
    @State var showMenu: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack {
            SideMenu(currentTab: $currentTab)
                
            CustomTabView(currentTab: $currentTab, showMenu: $showMenu)
                .cornerRadius(showMenu ? 25 : 0)
                .rotation3DEffect(.init(degrees: showMenu ? -15 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                
                .offset(x: showMenu ? getRect().width / 2 : 0)
                .ignoresSafeArea()
        }
        
        .preferredColorScheme(.dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}
