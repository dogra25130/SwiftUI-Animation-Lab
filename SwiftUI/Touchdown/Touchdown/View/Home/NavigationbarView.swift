//
//  NavigationbarView.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import SwiftUI

struct NavigationbarView: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            LogoView()
                .opacity(isAnimating ? 1 : 0)
                .offset(x: 0, y: isAnimating ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimating.toggle()
                    }
                })
            Spacer()
            Button(action: {}) {
                ZStack {
                    Image(systemName: "cart")
                        .font(.title)
                    .foregroundColor(.black)
                    
                    Circle()
                        .fill(.red)
                        .frame(width: 14, alignment: .center)
                        .offset(x: 13, y: -10)
                }
            }
        }
    }
}

struct NavigationbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationbarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
