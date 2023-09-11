//
//  Home.swift
//  HeroAnimation
//
//  Created by Abhishek Dogra on 10/09/23.
//

import SwiftUI

struct Home: View {
    @State var currentItem: ColorValue?
    @State var expandCard: Bool = false
    @State var moveCardDown: Bool = false
    @State var animateContent: Bool = false
    @State private var opacity: Double = 0

    @Namespace var animation
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            Color.black
                .zIndex(0)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(colors) { color in
                        CardView(item: color, rectSize: size)
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
            }
            
            .safeAreaInset(edge: .top) {
                Rectangle()
                    .frame(height: safeArea.top + 5)
            }
            .ignoresSafeArea(.container, edges: .all)
            .overlay {
                if let currentItem, expandCard {
                    DetailView(item: currentItem, rectSize: size)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 10)))
                }
            }
        }
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func DetailViewContent(item: ColorValue) -> some View {
        VStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .frame(height: 1)
                    .scaleEffect(x: animateContent ? 1 : 0.001, anchor: .leading)
                
                VStack {
                    ScrollView {
                        VStack {
                            Image(uiImage: item.image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 350, height: 300)
                                .shadow(color: .white, radius: 10)
                                .padding()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(Array(item.description.enumerated()), id: \.element) { index, desc in
                                    Text("\(index + 1). \(desc)")
                                        .font(.body)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                        }
                    }
                    
                }
                .opacity(opacity)
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                withAnimation(.easeInOut.delay(0.4)) {
                    opacity = 1
                    animateContent = true
                }
            }
    }
    
    @ViewBuilder
    func DetailView(item: ColorValue, rectSize: CGSize) -> some View {
        ColorView(item: item, rectSize: rectSize)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                VStack(spacing: .zero) {
                    ColorDetails(item: item, rectSize: rectSize)
                    DetailViewContent(item: item)
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut.delay(0.2)) {
                    animateContent = false
                    opacity = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        expandCard = false
                        moveCardDown = false
                    }
                }
            }
    }
    
    @ViewBuilder
    func ColorView(item: ColorValue, rectSize: CGSize) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .fill(item.color.gradient)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .fill(item.color.opacity(0.5).gradient)
                    .rotationEffect(.init(degrees: 180))
            }
            .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    @ViewBuilder
    func CardView(item: ColorValue, rectSize: CGSize) -> some View {
        let tappedCard = item.id == currentItem?.id && moveCardDown
        
        if !(item.id == currentItem?.id && expandCard) {
            ColorView(item: item, rectSize: rectSize)
                .overlay {
                    ColorDetails(item: item, rectSize: rectSize)
                }
                .frame(height: 110)
                .contentShape(RoundedRectangle(cornerRadius: 4))
                .offset(y: tappedCard ? 30 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    currentItem = item
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.4)) {
                        moveCardDown = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 1)) {
                            expandCard = true
                        }
                    }
                }
        } else {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.clear)
                .frame(height: 100)
        }
        
    }
    
    @ViewBuilder
    func ColorDetails(item: ColorValue, rectSize: CGSize) -> some View {
        HStack(spacing: 5) {
            Text(item.title)
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.subtitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(item.source)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            .frame(width: rectSize.width * 0.4)
        }
        .padding(15)
        .matchedGeometryEffect(id: item.id.uuidString, in: animation)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
