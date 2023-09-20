//
//  CustomTabView.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: String
    @Binding var showMenu: Bool
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.spring()) {
                        showMenu = true
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .opacity(showMenu ? 0 : 1)
                Spacer()
                Text(currentTab)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .opacity(showMenu ? 0 : 1)
                Spacer()
                
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 8)
            .padding(.top, getSafeArea().top)
            TabView(selection: $currentTab) {
                GridView()
                    .tag("Photos")
                
                CommunityView()
                    .tag("Community")
                
                Text("Devices")
                    .tag("Devices")
                
                Text("Profile")
                    .tag("Profile")
            }
        }
        .disabled(showMenu)
        .overlay(alignment: .topLeading, content: {
            Button {
                withAnimation(.spring()) {
                    showMenu = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top)
        })
        .background(
            Color.black
            
        )
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
