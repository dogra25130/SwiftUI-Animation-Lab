//
//  ContentView.swift
//  DVD
//
//  Created by Abhishek Dogra on 15/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var velocity = CGPoint(x: 5, y: 5)
    private let width: CGFloat = 100
    private let height: CGFloat = 50
    private let screenBounds = UIScreen.main.bounds
    var body: some View {
        Text("DVD")
            .fontWeight(.heavy)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            
            .frame(width: width, height: height)
            
            .background(
                Rectangle()
                    .fill(.red)
                    .border(.black)
                    
            )
            
            .position(position)
            .onAppear{
                startAnimation()
            }
            .onReceive(Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()) { _ in
                updatePosition()
            }
            
        
    }
    
    func startAnimation() {
        velocity = CGPoint(x: 4, y: 4)
    }
    
    func updatePosition() {
        let newPosition = CGPoint(x: position.x + velocity.x, y: position.y + velocity.y)
        if newPosition.x < width / 2 || newPosition.x > screenBounds.width - width / 2 {
            velocity.x *= -1
        }

        if newPosition.y < -40 || newPosition.y > screenBounds.height - 1.6 * height {
            velocity.y *= -1
        }
        position = newPosition
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
