//
//  MotionAnimationView.swift
//  Africa
//
//  Created by Abhishek Dogra on 05/06/23.
//

import SwiftUI

struct MotionAnimationView: View {
    @State private var randomCircle = Int.random(in: 12...16)
    @State private var isAnimating: Bool = false
    func randomCoordinate(max: CGFloat) -> CGFloat {
        return CGFloat.random(in: 0...max)
    }
    func randomSize() -> CGFloat {
        return CGFloat.random(in: 10...300)
    }
    func randomScale() -> CGFloat {
        return CGFloat(Double.random(in: 0.1...2.0))
    }
    func randomSpeed() -> Double {
        return (Double.random(in: 0.025...1.0))
    }
    func randomDelay() -> Double {
        return (Double.random(in: 0...2.0))
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0...randomCircle, id: \.self) {item in
                    Circle()
                        .foregroundColor(Color.gray.opacity(0.16)).frame(width: randomSize(), alignment: .center)
                        .scaleEffect(isAnimating ? 1 : randomScale())
                        .animation(Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5).repeatForever().speed(randomSpeed()).delay(randomDelay()), value: isAnimating)

                        .onAppear(perform: {
                            isAnimating = true
                        })
                        .position(
                            x: randomCoordinate(max: geometry.size.width),
                            y: randomCoordinate(max: geometry.size.height)
                        )
                }
            }
            .drawingGroup()
        }
    }
}

struct MotionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MotionAnimationView()
    }
}
