//
//  ContentView.swift
//  CircleBounceAnimation
//
//  Created by Abhishek Dogra on 23/08/23.
//

import SwiftUI

struct ContentView: View {
    @State var moving = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#ff6961"))
                .frame(width: 20, height: 20)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true), value: moving)
            
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#ffb480"))
                .frame(width: 50, height: 50)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.05), value: moving)
            
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#f8f38d"))
                .frame(width: 80, height: 80)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.1), value: moving)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#42d6a4"))
                .frame(width: 110, height: 110)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.15), value: moving)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#08cad1"))
                .frame(width: 140, height: 140)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.2), value: moving)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#59adf6"))
                .frame(width: 170, height: 170)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.25), value: moving)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#9d94ff"))
                .frame(width: 200, height: 200)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.3), value: moving)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color(hex: "#c780e8"))
                .frame(width: 230, height: 230)
                .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                .offset(y: moving ? 150 : -200)
                .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.35), value: moving)
        }
        .onAppear {
            moving.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
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
