//
//  Home.swift
//  CarouselMovies
//
//  Created by Abhishek Dogra on 22/10/23.
//

import SwiftUI

struct Home: View {
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Films"
    @Namespace var animation
    @Environment (\.colorScheme) var scheme
    var body: some View {
        ZStack {
            BGView()
            
            VStack {
                NavBar()
                
                SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: movies) { movie in
                    GeometryReader { proxy in
                        let size = proxy.size
                        VStack {
                            Spacer()
                            Image(movie.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height - 200)
                                .cornerRadius(15)
                            
                            Text(movie.title)
                                .font(.title)
                                .bold()
                            
                            Text(movie.description)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                
                        }
                        
                    }
                }
                .padding(.top, 70)
            }
        }
    }
    
    @ViewBuilder
    func NavBar() -> some View {
        HStack(spacing: 0) {
            ForEach(["Films", "Localities"], id: \.self) { tab in
                Button {
                    withAnimation {
                        currentTab = tab
                    }
                } label: {
                    Text(tab)
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background {
                            if currentTab == tab {
                                Capsule()
                                    .fill(.ultraThinMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func BGView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            TabView(selection: $currentIndex) {
                ForEach(movies.indices, id: \.self) { index in
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            let color: Color = (scheme == .dark ? .black : .white)
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Home()
}
