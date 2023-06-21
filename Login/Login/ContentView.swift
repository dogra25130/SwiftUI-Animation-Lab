//
//  ContentView.swift
//  Login
//
//  Created by Abhishek Dogra on 21/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var index: Int = 0
    @State var move: Bool = true
    private var background: [Color] = [ .purple, .green, .yellow]
    var body: some View {
        VStack {
            Spacer()
            LabelView(index: $index, move: $move)
            Spacer()
            BottomBar()
                .padding(.bottom, 40)
                .background(.black)
                .cornerRadius(12)
                .frame(height: 250)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true, block: { _ in
                index = (index + 1) % 3
            })
        }
        .background(background[index])
        .animation(.easeOut, value: index)

        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
