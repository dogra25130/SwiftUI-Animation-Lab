//
//  ContentView.swift
//  circleAnimation
//
//  Created by Abhishek Dogra on 31/08/23.
//

import SwiftUI

struct ContentView: View {

    @State private var scaleInOut = false
    @State private var rotateInOut = false
    @State private var moveInOut = false
    @State private var isRotating = 0.0

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            ZStack {
                
                //MARK: - Cicle Set 1
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)

                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                
                //MARK: - Cicle Set 2
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)

                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                    .rotationEffect(.degrees(60))
                
                //MARK: - Cicle Set 3
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                    .rotationEffect(.degrees(120))
            }
            
            .scaleEffect(scaleInOut ? 10 : 1/400)
            .animation(Animation.easeInOut.repeatForever(autoreverses: true).speed(1/8), value: scaleInOut)
            .rotationEffect(.degrees(isRotating))
            .onAppear {
                moveInOut.toggle()
                scaleInOut.toggle()
                rotateInOut.toggle()
                withAnimation(.linear(duration: 3)
                    .repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
