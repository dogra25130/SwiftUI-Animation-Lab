//
//  ContentView.swift
//  DoubleSidedGallery
//
//  Created by Abhishek Dogra on 22/10/23.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var postImage: String
}

struct ContentView: View {
    @State var posts: [Post] = []
    @State var currentPost: String = ""
    @State var fullPreview: Bool = false
    var body: some View {
        TabView(selection: $currentPost) {
            ForEach(posts) { post in
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(post.postImage)
                        .resizable()
                        .frame(width: size.width, height: size.height)
                        .aspectRatio(contentMode: .fill)
                        .onTapGesture {
                            withAnimation {
                                fullPreview.toggle()
                            }
                        }
                }
                .tag(post.id)
                .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) { post in
                            Image(post.postImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 60, alignment: .center)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, lineWidth: 2)
                                        .opacity(currentPost == post.id ? 1 : 0)
                                }
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame(height: 80)
                .background(Color.black.opacity(0.25).ignoresSafeArea())
                .onChange(of: currentPost) {
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .center)
                    }
                }
            }
                .offset(y: fullPreview ? 150 : 0),
            alignment: .bottom
        )
        .onAppear {
            for index in 1...6 {
                posts.append(Post(postImage: "\(index)"))
            }
            currentPost = posts.first?.id ?? ""
        }
    }
}

#Preview {
    ContentView()
}
