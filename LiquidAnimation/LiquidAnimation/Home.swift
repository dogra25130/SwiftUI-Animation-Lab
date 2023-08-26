//
//  Home.swift
//  LiquidAnimation
//
//  Created by Abhishek Dogra on 26/08/23.
//

import SwiftUI
struct Home: View {
    @State private var offset: CGSize = .zero
    @State private var showHome: Bool = false
    let color: String = "#00BFA5"
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Color.init(hex: color)
                .ignoresSafeArea()
                .overlay {
                    VStack(alignment: .center, spacing: 20) {
                        Text("Welcome to SwiftUI")
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("SwiftUI revolutionizes UI development with its intuitive syntax, real-time previews, and seamless cross-platform capabilities, making app creation delightful and efficient.")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .fontWeight(.medium)
                            
                    }
                    .padding()
                }
                .clipShape(LiquidSwipe(offset: offset))
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.init(hex: color))
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    // Aniate swipe offset
                                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                        offset = value.translation
                                    }
                                })
                                .onEnded({ value in
                                    let screen = UIScreen.main.bounds
                                    withAnimation(.spring()) {
                                        // Validating
                                        if -offset.width > screen.width / 2 {
                                            // Remove view
                                            offset.width = -screen.height
                                            showHome.toggle()
                                        } else {
                                            offset = .zero
                                        }
                                    }
                                })
                        )
                        .offset(x: 15, y: 45)
                        // Hide while draging start
                        .opacity(offset == .zero ? 1 : 0)

                    , alignment: .topTrailing
                )
            if showHome {
                Text("Tap to go back")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.init(hex: color))
                    .onTapGesture {
                        // Reset view
                        // Just for tutorial
                        // Custimize for your own
                        withAnimation(.spring()) {
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
        }
    }
}

struct LiquidSwipe: Shape {
    var offset: CGSize
    var animatableData: CGSize.AnimatableData {
        get { return offset.animatableData }
        set { offset.animatableData = newValue }
    }
    func path(in rect: CGRect) -> Path {
            return Path { path in
                // When user moves left
                // Increase size both in top and bottom
                // So it will create a liquid swipe effect

                let width = rect.width + (-offset.width > 0 ? offset.width : 0)
                // First constructing rectangle shape
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height - 200))

                // Now constructing curve shape
                // From
                let from = 80 + offset.width
                path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))

                // Also add height
                var to = 180 + (offset.height) + (-offset.width)
                to = to < 180 ? 180 : to

                // Mid between 80 - 180
                let mid: CGFloat = 80 + ((to - 80) / 2)
                path.addCurve(
                    to: CGPoint(x: rect.width, y: to),
                    control1: CGPoint(x: width - 50, y: mid),
                    control2: CGPoint(x: width - 50, y: mid)
                )
            }
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
