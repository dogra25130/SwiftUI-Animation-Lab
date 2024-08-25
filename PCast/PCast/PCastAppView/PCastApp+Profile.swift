//
//  HomeView+Profile.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import SwiftUI
extension PCastAppView {
    var ProfileView: some View {
        ZStack {
            BackgroundView
            VStack(spacing: 16) {
                ProfileDetailView
                OptionsView
            }
            .ignoresSafeArea(edges: [.top, .bottom])
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                removal: .move(edge: .trailing)))
    }
}

extension PCastAppView {
    private var ProfileDetailView: some View {
        VStack(alignment: .leading, spacing: 24) {
            ProfileInfoTopBarView
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(Color.white)
            ProfileInfoView
        }
        .padding(.top, safeAreaInsets.top)
        .padding(.leading, 32)
        .padding(.bottom, 32)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: .zero,
                                   bottomLeadingRadius: 24,
                                   bottomTrailingRadius: .zero,
                                   topTrailingRadius: .zero,
                                   style: .circular)
            .fill(Color(hex: "060D15")))
        .padding(.leading, 40)
    }

    private var BackgroundView: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .fill(Color(hex: "081727"))
            .opacity(0.9)
            .ignoresSafeArea()
    }
    
    private var OptionsView: some View {
        ButtonsView
        .foregroundStyle(Color.white)
        .padding(.leading, 32)
        .padding(.top, 40)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 24,
                                   bottomLeadingRadius: .zero,
                                   bottomTrailingRadius: .zero,
                                   topTrailingRadius: .zero,
                                   style: .circular)
            .fill(Color(hex: "060D15")))
        .padding(.leading, 40)
    }
}

extension PCastAppView {
    
    private var ButtonsView: some View {
        VStack(alignment: .leading, spacing: 24) {
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "circle.hexagongrid.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Browse")
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width: 20, height: 16)
                    
                    Text("Subscribed")
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Favourites")
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("History")
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: 20, height: 16)
                    
                    Text("Payments")
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("Account Settings")
                    Spacer()
                }
            }
            
            Spacer()
            LogouButton
        }
    }
    
    private var LogouButton: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text("Logout")
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .frame(width: 14, height: 12)
                    .foregroundStyle(Color.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 24)
                .fill(Color(hex: "19232F")))
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 40)
        .padding(.trailing, 32)
        .addBounceButtonStyle()
    }
}

extension PCastAppView {
    private var ProfileInfoTopBarView: some View {
        HStack(spacing: 20) {
            Text("Hello, \nAbhishek")
                .font(.setFont(.medium500, 24))
            Spacer()
            Image(systemName: "bell.badge")
                .resizable()
                .foregroundStyle(Color.red,Color.white)
            
                .frame(width: 20, height: 20)
            Button {
                withAnimation {
                    topBarButton = .none
                }
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.trailing, 32)
        .foregroundStyle(Color.white)
    }
    
    private var ProfileInfoView: some View {
        HStack(spacing: 24) {
            Image("author1")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Listened Time")
                    Text("24:15:05")
                        .foregroundStyle(Color.gray)
                }
                VStack(alignment: .leading) {
                    Text("Playlist")
                    Text("27")
                        .foregroundStyle(Color.gray)
                }
                VStack(alignment: .leading) {
                    Text("Following")
                    Text("129")
                        .foregroundStyle(Color.gray)
                }
            }
            .font(.setFont(.regular400, 12))
        }

    }
}

#Preview {
    HomeView()
}
