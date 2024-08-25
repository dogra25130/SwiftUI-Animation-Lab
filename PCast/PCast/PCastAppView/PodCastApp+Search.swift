//
//  HomeView+Search.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import SwiftUI
extension PCastAppView {
    var SearchView: some View {
        ZStack {
            BackgroundView
                .onTapGesture {
                    isSearchFocused = false
                    resetSearchState()
                    withAnimation {
                        topBarButton = .none
                    }
                }
            VStack {
                SearchFieldView
                Spacer()
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                removal: .move(edge: .trailing)))
    }
    
    private var SearchFieldView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                TextField(text: $searchViewModel.searchText) {
                    Text("Search...")
                }
                .focused($isSearchFocused)
                
                if searchViewModel.searchText.isEmpty {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                } else {
                    if searchViewModel.searchInProgress {
                        ProgressView()
                            .frame(width: 20, height: 20)
                    } else {
                        Button {
                            searchViewModel.searchText = ""
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
            
            SearchCardView()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 24)
            .fill(Color(hex: "19232F")))
        .padding()
    }
    
    private var BackgroundView: some View {
        ZStack {
            Color(hex: "081727")
                .opacity(0.9)
                .ignoresSafeArea()
        }
    }
    
    func SearchCardView() -> some View {
        ScrollView {
            VStack {
                ForEach(searchViewModel.searchResults) { model in
                    HStack(spacing: 16) {
                        Image(model.image)
                            .resizable()
                            .frame(width: 70, height: 65)
                            .clipShape(Utils.unevenRoundedRectangle)
                        
                        VStack(alignment: .leading, spacing: .zero) {
                            Text(model.title)
                                .font(.setFont(.medium500, 14))
                                .padding(.bottom, 8)
                                .lineLimit(1)
                            HStack {
                                Image(systemName: "clock")
                                Text(model.duration)
                            }
                            .font(.setFont(.regular400, 12))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                            Text(model.authorName)
                                .font(.setFont(.regular400, 12))
                        }
                        Spacer(minLength: .zero)
                    }
                }
            }
            .padding(.top, searchViewModel.searchResults.count > 0 ? 16 : .zero)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SearchScrollViewPreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SearchScrollViewPreferenceKey.self) { value in
                withAnimation {
                    searchScrollViewContentSize = value
                }
            }
        }
        .frame(height: searchScrollViewContentSize.height)
    }
    
    private func resetSearchState() {
        searchViewModel.searchText = ""
        searchViewModel.searchResults = []
        searchScrollViewContentSize = .zero
    }
}

struct SearchScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        defaultValue = nextValue()
    }
}

#Preview {
    HomeView()
}
