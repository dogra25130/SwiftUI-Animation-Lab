//
//  ContentView.swift
//  RotationAnimation
//
//  Created by Abhishek Dogra on 23/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var is3DYRotating = 360.0
    var body: some View {
        Image("rupee")
            .resizable()
            .scaledToFit()
            .frame(width: 178, height: 232)
            .rotation3DEffect(.degrees(is3DYRotating * 2),
                              axis: (x: 0,
                                     y: is3DYRotating,
                                     z: 0))
            .animation(.easeInOut(duration: 6).repeatForever(),
                       value: is3DYRotating)
            .onAppear {
                is3DYRotating = .random(in: 1...80)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
