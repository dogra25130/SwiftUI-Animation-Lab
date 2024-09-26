//
//  BrowseView.swift
//  PCast
//
//  Created by Abhishek Dogra on 01/09/24.
//

import SwiftUI

class BrowseViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchInProgress = false
}

struct BrowseView: View {
    @StateObject var viewModel = BrowseViewModel()
    @FocusState var isSearchFocused: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .zero) {
                HStack {
                    Text("Browse")
                        .font(.setFont(.bold700, 48))
                    Spacer()
                }
                HStack {
                    TextField(text: $viewModel.searchText) {
                        Text("Search...")
                    }
                    .focused($isSearchFocused)
                    
                    if viewModel.searchText.isEmpty {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } else {
                        if viewModel.searchInProgress {
                            ProgressView()
                                .frame(width: 20, height: 20)
                        } else {
                            Button {
                                viewModel.searchText = ""
                            } label: {
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(Color.white)
                            }
                        }
                    }
                }
                .font(.setFont(.medium500, 14))
                .padding()
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(Color.black))
                
                ScrollView(.horizontal) {
                        HStack {
                            VStack {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .fill(Color.white.opacity(0.2))
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 56, height: 56)
                                    .padding()
                                    .clipShape(Circle())
                                    .overlay {
                                        Image(systemName: "music.quarternote.3")
                                    }
                                
                                Text("Topics")
                                    .font(.setFont(.medium500, 12))
                            }
                            VStack {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .frame(width: 56, height: 56)
                                    .padding()
                                    .clipShape(Circle())
                                    .overlay {
                                        Image(systemName: "music.quarternote.3")
                                    }
                                Text("Topics")
                            }
                            VStack {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .frame(width: 56, height: 56)
                                    .padding()
                                    .clipShape(Circle())
                                    .overlay {
                                        Image(systemName: "music.quarternote.3")
                                    }
                                Text("Topics")
                            }
                            VStack {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .frame(width: 56, height: 56)
                                    .padding()
                                    .clipShape(Circle())
                                    .overlay {
                                        Image(systemName: "music.quarternote.3")
                                    }
                                Text("Topics")
                            }
                            VStack {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .frame(width: 56, height: 56)
                                    .padding()
                                    .clipShape(Circle())
                                    .overlay {
                                        Image(systemName: "music.quarternote.3")
                                    }
                                Text("Topics")
                            }
                        }
                }
            }
            .padding(.top, 32)
                
        }
        .scrollIndicators(.hidden)
        .padding()
        .background(Color(hex: "081727"))
    }
}

