//
//  ContentView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem ({
                    Image("tabicon-branch")
                    Text("Avocados")
                })
            RecipesView()
                .tabItem ({
                    Image("tabicon-book")
                    Text("Recipes")
                        
                })
            RipeningView()
                .tabItem ({
                    Image("tabicon-avocado")
                    Text("Ripening")
                        .foregroundColor(.red)
                })
            Settings()
                .tabItem ({
                    Image("tabicon-settings")
                    Text("Settings")
                        .font(.title3)
                })
        }
        .accentColor(Color.primary)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
