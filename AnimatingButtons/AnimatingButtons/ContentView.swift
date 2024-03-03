//
//  ContentView.swift
//  AnimatingButtons
//
//  Created by Abhishek Dogra on 29/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var hide13: Bool = false
    var body: some View {
        VStack {
            Text("Text 0")
            if hide13 == false {
                Text("Text 1")
                Text("Text 2")
                Text("Text 3")
            }
            Text("Text 4")
            Text("Text 5")
            Button("hide 1 - 3") {
                withAnimation(.spring(duration: 0.3, bounce: 0.4, blendDuration: 0.3 )) {
                    hide13.toggle()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
