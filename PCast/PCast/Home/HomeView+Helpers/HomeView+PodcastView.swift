//
//  HomeView+PodcastView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

typealias PodcastView = HomeView
extension PodcastView {
    @ViewBuilder
    var PodCastView: some View {
        if let homeDataModel = viewModel.homeDataModel {
            VStack(alignment: .leading, spacing: 24) {
                Text(homeDataModel.trendingPodcastModel.headline)
                    .font(.setFont(.medium500, 24))
                
                HStack {
                    ForEach(homeDataModel.trendingPodcastModel.podcastSectionModel) { model in
                        Button {
                            viewModel.updateCurrentTrendingPodcastModel(with: model)
                        } label: {
                            Text(model.sectionName)
                                .font(.setFont(.regular400, 14))
                        }
                        .foregroundStyle(viewModel.currentTrendingPodcastModel?.id == model.id ? Color.blue : Color.gray)
                        .addBounceButtonStyle()
                    }
                }
                
                if let currentTrendingPodcastModel = viewModel.currentTrendingPodcastModel {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(currentTrendingPodcastModel.podcastModel) { model in
                                PodCastCard(with: model)
                                    .frame(width: 150)
                                
                            }
                        }
                        
                    }
                }
            }
            .padding(32)
        }
    }
    
    private func PodCastCard(with model: PodCastModel) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Image(model.image)
                .resizable()
                .background(Color.red)
                .frame(width: 150, height: 150)
                .clipShape(Utils.unevenRoundedRectangle)
                .padding(.bottom, 16)
            Text(model.title)
                .font(.setFont(.medium500, 14))
                .padding(.bottom, 12)
                .lineLimit(2, reservesSpace: true)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(model.duration)
                    }
                    .foregroundStyle(Color.gray)
                    HStack {
                        Image(systemName: "circle.fill")
                        Text(model.authorName)
                    }
                }
                .font(.setFont(.regular400, 12))
                Spacer()
                Circle()
                    .fill(Color.blue)
                    .overlay {
                        Image(systemName: "play")
                            .bold()
                    }
                    .frame(width: 32, height: 32)
            }
            .font(.setFont(.regular400, 12))
        }
    }
}
