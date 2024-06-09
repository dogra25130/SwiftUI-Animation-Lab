//
//  ContentView.swift
//  FullScreenAnimation
//
//  Created by Abhishek Dogra on 09/06/24.
//

import SwiftUI

struct ContentView: View {
    @State var shouldExpand: Bool = false
    @Namespace var namespace
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Games")
                            .font(.largeTitle)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Image("1_1")
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            HStack(alignment: .center, spacing: 16) {
                                                Image("1")
                                                    .resizable()
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    .frame(width: 50, height: 50)
                                                VStack(alignment: .leading) {
                                                    Text("Cyber Hunt")
                                                        .foregroundStyle(Color.white)
                                                        .bold()
                                                    Text("Epic 3v3 and Battle")
                                                        .font(.caption)
                                                        .foregroundStyle(Color.white)
                                                        .frame(maxWidth: .infinity,  alignment: .leading)
                                                }
                                                Spacer()
                                                Button {
                                                    
                                                } label: {
                                                    Text("GET")
                                                        .bold()
                                                        .foregroundStyle(Color.white)
                                                        .padding(.horizontal, 25)
                                                        .padding(.vertical, 5)
                                                        .background(RoundedRectangle(cornerRadius: 20)
                                                            .foregroundStyle(Color.gray.opacity(0.5)))
                                                }
                                                .fixedSize(horizontal: true, vertical: true)
                                            }
                                            .padding()
                                            .background(Rectangle().fill(.ultraThinMaterial)
                                                .clipShape(.rect(topLeadingRadius: 16,
                                                                 topTrailingRadius: 16)))
                                        }
                                    }
                                    .frame(width: proxy.size.width - 20, height: 300)
                                    
                                    .matchedGeometryEffect(id: "shape", in: namespace)
                                    .onTapGesture {
                                        withAnimation(.bouncy) {
                                            shouldExpand = true
                                        }
                                    }
                                
                                Image("9")
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            HStack(alignment: .center, spacing: 16) {
                                                Image("2")
                                                    .resizable()
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    .frame(width: 50, height: 50)
                                                VStack(alignment: .leading) {
                                                    Text("Shadowlands")
                                                        .foregroundStyle(Color.white)
                                                        .bold()
                                                    Text("Dark fantasy realm")
                                                        .font(.caption)
                                                        .foregroundStyle(Color.white)
                                                        .frame(maxWidth: .infinity,  alignment: .leading)
                                                }
                                                Spacer()
                                                Button {
                                                    
                                                } label: {
                                                    Text("GET")
                                                        .bold()
                                                        .foregroundStyle(Color.white)
                                                        .padding(.horizontal, 25)
                                                        .padding(.vertical, 5)
                                                        .background(RoundedRectangle(cornerRadius: 20)
                                                            .foregroundStyle(Color.gray.opacity(0.5)))
                                                }
                                                .fixedSize(horizontal: true, vertical: true)
                                            }
                                            .padding()
                                            .background(Rectangle().fill(.ultraThinMaterial)
                                                .clipShape(.rect(topLeadingRadius: 16,
                                                                 topTrailingRadius: 16)))
                                        }
                                    }
                                    .frame(width: proxy.size.width - 20, height: 300)
                                    .foregroundStyle(Color.yellow)
                                
                                Image("10")
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            HStack(alignment: .center, spacing: 16) {
                                                Image("7")
                                                    .resizable()
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    .frame(width: 50, height: 50)
                                                VStack(alignment: .leading) {
                                                    Text("Mystic War")
                                                        .foregroundStyle(Color.white)
                                                        .bold()
                                                    Text("Magical combat saga")
                                                        .font(.caption)
                                                        .foregroundStyle(Color.white)
                                                        .frame(maxWidth: .infinity,  alignment: .leading)
                                                }
                                                Spacer()
                                                Button {
                                                    
                                                } label: {
                                                    Text("GET")
                                                        .bold()
                                                        .foregroundStyle(Color.white)
                                                        .padding(.horizontal, 25)
                                                        .padding(.vertical, 5)
                                                        .background(RoundedRectangle(cornerRadius: 20)
                                                            .foregroundStyle(Color.gray.opacity(0.5)))
                                                }
                                                .fixedSize(horizontal: true, vertical: true)
                                            }
                                            .padding()
                                            .background(Rectangle().fill(.ultraThinMaterial)
                                                .clipShape(.rect(topLeadingRadius: 16,
                                                                 topTrailingRadius: 16)))
                                        }
                                    }
                                    .frame(width: proxy.size.width - 20, height: 300)
                                    .foregroundStyle(Color.yellow)
                            }
                            .padding(.vertical)
                        }
                        
                        RoundedRectangle(cornerRadius: 1)
                            .frame(height: 0.5)
                            .foregroundStyle(Color.gray.opacity(0.5))
                        
                        VStack {
                            HStack {
                                Text("Must-Play Games")
                                    .font(.title)
                                    .bold()
                                Spacer()
                                Text("See All")
                                    .foregroundStyle(Color.blue)
                            }
                            GameTile(imageVal: "4", title: "Skyfall", desc: "Epic aerial battles")
                            GameTile(imageVal: "6", title: "Starlight", desc: "Galactic exploration adventure")
                            GameTile(imageVal: "8", title: "Battlefront", desc: "Intense war zones", showDivider: false)
                            GameTile(imageVal: "3", title: "Dungeon Quest", desc: "Underground treasure hunting")
                        }
                    }
                }
                if shouldExpand {
                    Image("1.1")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            VStack(alignment: .leading) {
                                Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Cyber Hunt: Neon Pursuit")
                                            .bold()
                                            .foregroundStyle(Color.white)
                                        Text("Dive into futuristic cities, hunting elusive targets in thrilling chases.")
                                            .font(.caption)
                                            .foregroundStyle(Color.white)
                                        
                                        HStack(alignment: .center, spacing: 16) {
                                            Image("1")
                                                .resizable()
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .frame(width: 50, height: 50)
                                            VStack(alignment: .leading) {
                                                Text("Cyber Hunt")
                                                    .foregroundStyle(Color.white)
                                                    .bold()
                                                Text("Epic 3v3 and Battle")
                                                    .font(.caption)
                                                    .foregroundStyle(Color.white)
                                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                            }
                                            Spacer()
                                            Button {
                                                
                                            } label: {
                                                Text("GET")
                                                    .bold()
                                                    .foregroundStyle(Color.white)
                                                    .padding(.horizontal, 25)
                                                    .padding(.vertical, 5)
                                                    .background(RoundedRectangle(cornerRadius: 20)
                                                        .foregroundStyle(Color.gray.opacity(0.5)))
                                            }
                                            .fixedSize(horizontal: true, vertical: true)
                                        }
                                    }
                                    .padding()
                                    .background {
                                        Rectangle().fill(.ultraThinMaterial)
                                            .blur(radius: 10)
                                    }
                                    
                                
                            }
                            

                        }
                        .matchedGeometryEffect(id: "shape", in: namespace)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                shouldExpand = false
                            }
                        }
                }
            }
        }
        .padding(.horizontal)
        .ignoresSafeArea(.all, edges: .horizontal)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func GameTile(imageVal: String, title: String, desc: String, showDivider: Bool = true) -> some View {
        HStack(spacing: 16) {
            Image(imageVal)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                Text(desc)
                    .font(.callout)
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity,  alignment: .leading)
            }
            Spacer()
            Button {
                
            } label: {
                Text("GET")
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.gray.opacity(0.2)))
            }
            .fixedSize(horizontal: true, vertical: true)
        }
        if showDivider {
            RoundedRectangle(cornerRadius: 1)
                .frame(height: 0.5)
                .foregroundStyle(Color.gray.opacity(0.5))
        }
    }
}

#Preview {
    ContentView()
}
