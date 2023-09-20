//
//  ContentView.swift
//  ScrollViewRefreshable
//
//  Created by Abhishek Dogra on 20/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var posts: [Post] = []
    @State var columns: Int = 2
    @Namespace var animation
    var body: some View {
        NavigationView {
            StaggeredGrid(columns: columns, list: posts) { post in
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
            }
            .padding(.horizontal)
            .navigationTitle("Staggered Grid")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns += 1
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns = max(1, columns - 1)
                    } label: {
                        Image(systemName: "minus")
                    }

                }
            }
        }
        .animation(.easeInOut, value: columns)
        .onAppear {
            for index in 1...10 {
                posts.append(Post(imageURL: "\(index)"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PostCardView: View {
    
    var post: Post
    var body: some View {
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
