//
//  SideMenu.swift
//  Socius
//
//  Created by Abhishek Dogra on 16/09/23.
//

import SwiftUI

struct SideMenu: View {
    @Binding var currentTab: String
    @Namespace var animation
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                Text("Abhishek")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    CustomTabButton(icon: "theatermasks.fill", title: "Photos")
                    CustomTabButton(icon: "safari.fill", title: "Community")
                    CustomTabButton(icon: "applewatch", title: "Devices")
                    CustomTabButton(icon: "person.fill", title: "Profile")
                    CustomTabButton(icon: "gearshape.fill", title: "Setting")
                    CustomTabButton(icon: "info.circle.fill", title: "About")
                    CustomTabButton(icon: "questionmark.circle.fill", title: "Help")
                    Spacer()
                    
                    CustomTabButton(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
                }
                .padding()
                .padding(.top, 45)
            }
            .frame(width: getRect().width / 2 + 5, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color.indigo
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func CustomTabButton(icon: String, title: String) -> some View {
        Button {
            if title == "Logout" {
                
            } else {
                withAnimation {
                    currentTab = title
                }
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab == title ? 48 : nil, height: 48)
                    .foregroundColor(currentTab == title ? .purple : (title == "Logout" ? .orange : .white))
                    .background(
                        ZStack {
                            if currentTab == title {
                                Color.white
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TABCIRCLE", in: animation)
                            }
                        }
                    )
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(title == "Logout" ? .orange : .white)
            }
            .padding(.trailing)
            .background(
                ZStack {
                    if currentTab == title {
                        Color(.purple)
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "TABCAPSULE", in: animation)
                    }
                }
            )
        }
        .offset(x: currentTab == title ? 15 : 0)

    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
