//
//  ContentView.swift
//  Restart
//
//  Created by Abhishek Dogra on 01/06/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingScreenActive: Bool = true
    var body: some View {
        ZStack {
            if isOnboardingScreenActive {
                OnboardingView()
            }else {
                HomeView()
            }
        }
        .animation(.easeOut(duration: 0.4), value: isOnboardingScreenActive)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
