//
//  ContentView.swift
//  AppStoreAnimation
//
//  Created by Abhishek Dogra on 10/03/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentItem: DataModel?
    @State var showDetailsPage: Bool = false
    @Namespace var animation
    @State var animateView = false
    @State var animateContent = false
    @State var scrollOffset: CGFloat = 0.0
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sunday 10 March")
                            .font(.callout)
                            .foregroundStyle(Color.gray)
                        Text("Foo-day!")
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    }
                }
                .padding(.horizontal, 12)
                .opacity(showDetailsPage ? 0 : 1)
                
                ForEach(dataItems) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            showDetailsPage = true
                            currentItem = item
                        }
                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailsPage ? 1 : 0.95)
                            
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailsPage ? (item.id == currentItem?.id ? 1 : 0) : 1)
                }
            }
        }
        .overlay {
            if let currentItem, showDetailsPage {
                DetailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThinMaterial)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func CardView(item: DataModel) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(item.artWork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                }
                .frame(height: 400)
                
                LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0.2), .clear],
                               startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                }
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }
            
            HStack(spacing: 12) {
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.appName)
                        .fontWeight(.bold)
                    
                    Text(item.appDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .foregroundColor(.primary)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    @ViewBuilder
    private func DetailView(item: DataModel) -> some View {
        VStack {
            CardView(item: item)
                .scaleEffect(animateView ? 1 : 0.95)
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            animateView = false
                            animateContent = false
                        }
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                            currentItem = nil
                            showDetailsPage = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.top, safeArea().top)
                    .opacity(animateView ? 1 : 0)
                })
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Text(item.desc)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding()
                        .padding(.bottom, 20)
                        .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                        .opacity(animateContent ? 1 : 0)
                        .scaleEffect(animateView ? 1 : 0, anchor: .top)
                }
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
                .offset(offset: $scrollOffset)
            }
            .coordinateSpace(name: "SCROLL")
            
            .onAppear(perform: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = true
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                    animateContent = true
                }
            })
            .transition(.identity)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
    
    func offset(offset: Binding<CGFloat>) -> some View {
        return self.overlay {
            GeometryReader(content: { geometry in
                let minY = geometry.frame(in: .named("SCROLL")).minY
                
                Color.clear.preference(key: OffsetKey.self, value: minY)
            })
            .onPreferenceChange(OffsetKey.self, perform: { value in
                offset.wrappedValue = value
            })
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
