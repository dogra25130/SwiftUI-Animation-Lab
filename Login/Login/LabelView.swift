//
//  LabelView.swift
//  Login
//
//  Created by Abhishek Dogra on 21/06/23.
//

import SwiftUI

struct LabelView: View {
    @Binding var index: Int
    @Binding var move: Bool
    var background: [Color] = [ .purple, .green, .yellow]
    var label: [String] = ["Let's create", "Let's invent", "Let's enjoy"]
    
    var body: some View {
        let width: CGFloat = 175
        HStack {
            Circle()
                .fill(.black)
                .frame(width: 35)
                .offset(x: move ? -width / 2 + 10: width / 2)
                .background(alignment: .leading, content: {
                    Capsule()
                        .fill(background[index])
                        .frame(width: width)
                        .offset(x: move ? -width / 2 + 10: width / 2)
                })
                .background(
                    Text(label[index])
                        .font(.title)
                        .frame(width: width)
                    
                )
                .onAppear {
                    withAnimation(.easeOut(duration: 1).delay(0.1).repeatForever(autoreverses: true)) {
                        move.toggle()
                    }
                }
        }
    }
}
