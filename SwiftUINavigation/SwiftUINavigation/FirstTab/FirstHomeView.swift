//
//  FirstHomeView.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

struct FirstHomeView: View {
    var router: FirstCoordinator
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .font(.system(size: 56))
                .foregroundColor(.accentColor)
            Text("**Home**")
                .font(.system(size: 24))
            
            Button {
                router.navigate(to: .livingRoom)
            } label: {
                Text("**Go to Livingroom**")
            }
            .padding(.top, 12)
            
            Button {
                router.navigate(to: .bedroom(owner: "Abhishek"))
            } label: {
                Text("**Go to Bedroom**")
            }
            .padding(.top, 12)

        }
        .padding()
    }
}
