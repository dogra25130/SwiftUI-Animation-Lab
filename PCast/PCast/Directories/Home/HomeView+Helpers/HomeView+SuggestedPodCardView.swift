//
//  HomeView+SuggestedPodCardView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

typealias SuggestedPodCardView = HomeView
extension SuggestedPodCardView {
    var SuggestedPodCastView: some View {
        VStack {
            SuggestedPodCardViewHorizontalScroll
                .padding(32)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, safeAreaInsets.top + 45)
        .background(GradientBackground.opacity(viewModel.homeDataModel.isNil ? 0 : 1))
    }
    
    var SuggestedPodCardViewHorizontalScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.homeDataModel?.suggestionPodCastModel ?? []) { model in
                    getSuggestionCardView(with: model)
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
            
        }
        .scrollTargetBehavior(.viewAligned)
        
        
    }
    
    private func getSuggestionCardView(with model: PodCastModel) -> some View {
        Button {
            coordinator.navigateTo(.podcast(model))
        } label: {
            VStack(alignment: .leading, spacing: .zero) {
                Text(model.title)
                    .font(.setFont(.medium500, 24))
                    .padding(.bottom, 20)
                HStack {
                    VStack(spacing: 8) {
                        HStack {
                            Text(model.date)
                            Image(systemName: "clock")
                            Text(model.duration)
                            Spacer()
                        }
                        .foregroundStyle(Color.gray)
                        HStack {
                            Image(systemName: "circle.fill")
                            Text(model.authorName)
                            Spacer()
                        }
                    }
                    .font(.setFont(.regular400, 12))
                    Spacer()
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "play").bold()
                        }
                }
            }
            .padding(32)
            .background(
                Image(model.image)
                    .resizable()
                    .clipShape(Utils.unevenRoundedRectangle)
            )
            .overlay {
                VStack {
                    HStack {
                        Text("NEW")
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .foregroundStyle(Color.white)
                            .font(.setFont(.black900, 12))
                            .background(RoundedRectangle(cornerRadius: 12)
                                .fill(Color.red))
                        Spacer()
                    }
                    Spacer()
                }
                .offset(x: 42, y: -10)
            }
            .padding(.vertical)
        }
        .addBounceButtonStyle()
    }
}
