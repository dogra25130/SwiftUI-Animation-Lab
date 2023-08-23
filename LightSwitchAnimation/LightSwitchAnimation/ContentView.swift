//
//  ContentView.swift
//  LightSwitchAnimation
//
//  Created by Abhishek Dogra on 22/08/23.
//

import SwiftUI

struct ContentView: View {
    let appWidth = UIScreen.main.bounds.width
    let appHeight = UIScreen.main.bounds.height
    let animationDuration: TimeInterval = 0.35
    
    @State var xScale: CGFloat = 0.4
    @State var yScale: CGFloat = 2
    @State var yOffset: CGFloat = UIScreen.main.bounds.height
    
    @State var isOffset: Bool = true
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Circle()
                .fill(Color.mint)
                .scaleEffect(CGSize(width: xScale, height: yScale))
                .offset(y: yOffset)
            VStack {
                ZStack {
                    Capsule()
                        .foregroundColor(.gray)
                        .frame(width: 52, height: appHeight * 0.25 + 6)
                        .opacity(0.275)
                        .offset(x: appWidth / 2 - 48, y: 16)
                    ZStack {
                        Capsule()
                            .frame(width: 3, height: isOffset ? appHeight * 0.41 : appHeight * 0.625)
                            .foregroundColor(.white)
                        Capsule()
                            .fill(Color.white)
                            .frame(width: 42, height: 42)
                            .offset(y: isOffset ? appHeight * 0.225 : appHeight * 0.25 + 42)
                    }
                    .offset(x: appWidth / 2 - 48, y: -appHeight / 2)
                    .frame(height: 0, alignment: .top)
                }
                .onTapGesture {
                    toggleLights()
                }
                .animation(.spring(dampingFraction: 0.65).speed(1.25))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    func toggleLights() {
        if isOffset {
            withAnimation(.easeIn(duration: animationDuration)) {
                xScale = 4
                yScale = 4
                yOffset = 0
            }
        }else {
            withAnimation(.easeOut(duration: animationDuration * 0.75)) {
                xScale = 0.4
                yScale = 2
                yOffset = UIScreen.main.bounds.height
            }
        }
        isOffset.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
