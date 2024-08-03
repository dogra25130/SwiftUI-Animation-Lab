//
//  LoadingStateView.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 19/07/24.
//

import SwiftUI
struct CircularLoaderView: View {
    @State private var animate = false
    var frame: CGSize? = nil
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .primary, location: 0.1),
            Gradient.Stop(color: .primary.opacity(0.8), location: 0.4),
            Gradient.Stop(color: .primary.opacity(0.4), location: 0.8)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: .p4)
            .frame(width: frame?.width ?? .p16, height: frame?.height ?? .p16)
            .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .padding(3)
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                withAnimation {
                    animate.toggle()
                }
            }
    }
}
