//
//  HomeView+GradientBackgroundView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

typealias GradientBackground = HomeView
extension GradientBackground {
    var GradientBackground: some View {
        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 24, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .circular)
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(hex: "#1A0033").opacity(0.5)]),
                startPoint: .zero,
                endPoint: .bottom
            ))
            .ignoresSafeArea()
    }
}
