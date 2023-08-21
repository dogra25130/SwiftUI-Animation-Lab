//
//  OnboardingView.swift
//  Restart
//
//  Created by Abhishek Dogra on 01/06/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingScreenActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffSet: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffSet: CGSize = .zero
    @State private var textTitle: String = "Share."
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                Spacer()
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                    Text("""
                    It's not how much we give but
                    it's about how much love we put in giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeIn(duration: 1), value: isAnimating)
                
                ZStack {
                    CircleGroup(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width) / 5)
                        .animation(.easeInOut(duration: 0.5), value: imageOffSet)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffSet.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffSet.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffSet.width) <= 150 {
                                        imageOffSet = gesture.translation
                                    }
                                    withAnimation(.linear(duration: 0.25)) {
                                        textTitle = "Give."
                                    }
                                }
                                .onEnded({ _ in
                                    imageOffSet = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        textTitle = "Share."
                                    }
                                })
                        )
                        .animation(.easeInOut(duration: 0.5), value: imageOffSet)
                }
                
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffSet + 80)
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffSet)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80 {
                                        buttonOffSet = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    if buttonOffSet > buttonWidth / 2 {
                                        buttonOffSet = buttonWidth - 80
                                        isOnboardingScreenActive = false
                                    } else {
                                      buttonOffSet = 0
                                    }
                                })
                        )
                        Spacer()
                    }
                    
                    
                    
                }
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                .padding()
            }
        }
        .onAppear {
            isAnimating = true
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
