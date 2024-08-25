//
//  HomeView+AuthorView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

typealias AuthorView = HomeView
extension AuthorView {
    
    @ViewBuilder
    var AuthorView: some View {
        if let homeDataModel = viewModel.homeDataModel {
            VStack(alignment: .leading, spacing: 24) {
                Text(homeDataModel.authorPodcastModel.headline)
                    .font(.setFont(.medium500, 24))
                
                HStack {
                    ForEach(homeDataModel.authorPodcastModel.authorSectionModel) { model in
                        Button {
                            viewModel.updateCurrentAuthor(with: model)
                        } label: {
                            Text(model.sectionName)
                                .font(.setFont(.regular400, 14))
                        }
                        .foregroundStyle(viewModel.currentAuthor?.id == model.id ? Color.blue : Color.gray)
                        .addBounceButtonStyle()
                    }
                }
                
                if let currentAuthor = viewModel.currentAuthor {
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(currentAuthor.authors) { model in
                            getAuthorView(for: model)
                            
                        }
                    }
                    
                }
            }
            .padding(32)
        }
    }
    private func getAuthorView(for model: AuthorDetail) -> some View {
        VStack(spacing: .zero) {
            Image(model.image)
                .resizable()
                .frame(width: 64, height: 64)
                .background(Color.red)
                .clipShape(Circle())
                .padding(.bottom, 8)
            
            Text(model.name)
                .padding(.bottom, 2)
            
            Text("Podcasts: \(model.numberOfPodcasts)")
                .foregroundStyle(Color.gray)
        }
        .font(.setFont(.regular400, 12))
        .frame(width: 100)
    }
}
