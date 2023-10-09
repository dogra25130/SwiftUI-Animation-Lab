//
//  ContentView.swift
//  BoomerangCards
//
//  Created by Abhishek Dogra on 08/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var cardView: CardModel
    var isRotated: Bool = false
    var extraOffset: CGFloat = 0
    var scale: CGFloat = 1
    var zIndex: Double = 0
}
