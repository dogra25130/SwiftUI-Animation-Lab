//
//  HomeView.swift
//  Restart
//
//  Created by Abhishek Dogra on 01/06/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingScreenActive: Bool = false
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            //  MARK: HEADER
            Spacer()
            ZStack {
                CircleGroup(shapeColor: .gray, shapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation.easeInOut(duration: 4).repeatForever(), value: isAnimating)
            }
            
            //  MARK: CENTER
            Text("The time that leads to mastery is dependent of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            //  MARK: FOOTER
            Spacer()
            Button {
                withAnimation {
                    isOnboardingScreenActive = true
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
