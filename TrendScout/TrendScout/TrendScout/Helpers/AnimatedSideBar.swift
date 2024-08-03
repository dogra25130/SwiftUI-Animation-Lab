//
//  AnimatedSideBar.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 22/07/24.
//

import SwiftUI

enum MenuOptions: String, CaseIterable {
    case accessories = "Accessories"
    case clothes = "Clothes"
    case jewellery = "Jewellery"
    case premium = "Premium Store"
    case profile = "Profile"
    case logout = "Logout"
    
    var title: String {
        switch self {
        case .clothes:
            "Clothes"
        case .jewellery:
            "Jewellery"
        case .accessories:
            "Accessories"
        case .premium:
            "Premium"
        case .profile:
            "Profile"
        case .logout:
            "Logout"
        }
    }
    
    var image: String {
        switch self {
        case .clothes:
            "bag"
        case .jewellery:
            "sparkles"
        case .accessories:
            "sunglasses"
        case .premium:
            "wand.and.stars.inverse"
        case .profile:
            "person.circle"
        case .logout:
            "lock"
        }
    }
}

struct AnimatedSideBar<Content: View, MenuView: View, Background: View>: View {
    var sideMenuWidth = 200.0
    var cornerRadius = 25.0
    @Binding var showMenu: Bool
    @ViewBuilder var content: (UIEdgeInsets) -> Content
    @ViewBuilder var menuView: (UIEdgeInsets) -> MenuView
    @ViewBuilder var background: Background
    
    @GestureState private var isDragging = false
    @State private var offsetX: CGFloat = .zero
    @State private var lastOffsetX: CGFloat = .zero
    @State private var progress: CGFloat = .zero
    
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets ?? .zero
            
            HStack(spacing: .zero) {
                GeometryReader { _ in
                    menuView(safeArea)
                }
                .frame(width: sideMenuWidth)
                .clipShape(.rect)
                
                GeometryReader { _ in
                    content(safeArea)
                }
                .frame(width: size.width)
                .overlay {
                    if progress > .zero {
                        Rectangle()
                            .fill(Color.gray.opacity(progress * 0.2))
                            .onTapGesture {
                                withAnimation {
                                    resetState()
                                }
                            }
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: progress * cornerRadius)
                }
                .scaleEffect(1 - progress * 0.1)
                .rotation3DEffect(Angle(degrees: progress *  -15),
                                  axis: (0.0, 1.0, 0.0))
            }
            .frame(width: sideMenuWidth + size.width, height: size.height)
            .offset(x: -sideMenuWidth)
            .offset(x: offsetX)
            .contentShape(.rect)
//            .simultaneousGesture(dragGesture)
        }
        .background(background)
        .ignoresSafeArea()
        .onChange(of: showMenu, initial: true) { oldValue, newValue in
            withAnimation(.snappy(duration: 0.3)) {
                if newValue {
                    showSideBar()
                } else {
                    resetState()
                }                
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, out, _ in
                out = true
            }.onChanged { value in
                guard value.startLocation.x > .p10 else { return }
                let translationX = isDragging ? max(min(value.translation.width + lastOffsetX, sideMenuWidth), .zero) : .zero
                offsetX = translationX
                calculateProgress()
            }.onEnded { value in
                guard value.startLocation.x > .p10 else { return }
                withAnimation(.snappy(duration: 0.3)) {
                    let velocityX = value.velocity.width / .p8
                    let total = velocityX + offsetX
                    
                    if total > (sideMenuWidth * 0.5) {
                        showSideBar()
                    } else {
                        resetState()
                    }
                }
            }
    }
    
    private func showSideBar() {
        offsetX = sideMenuWidth
        lastOffsetX = offsetX
        showMenu = true
        calculateProgress()
    }
    
    private func resetState() {
        offsetX = .zero
        lastOffsetX = .zero
        showMenu = false
        calculateProgress()
    }
    
    private func calculateProgress() {
        progress = max(.zero, min(offsetX / sideMenuWidth, 1))
    }
}
