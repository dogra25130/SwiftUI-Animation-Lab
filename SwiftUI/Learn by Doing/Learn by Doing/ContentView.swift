//
//  ContentView.swift
//  Learn by Doing
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct ContentView: View {
    let cards: [Card] = cardData
    var body: some View {
        
        VStack {
            TabView {
                ForEach(cards) {card in
                    ItemView(card: card)
                }
            }
            .tabViewStyle(.page)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
