//
//  PodcastHeaderView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var PodcastHeaderView: some View {
        VStack(spacing: .zero) {
            if let title = viewModel.data?.title,
               let authors = viewModel.data?.authors {
                Text(title)
                    .font(.setFont(.medium500, 24))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 60)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                Text(authors)
                    .font(.setFont(.regular400, 14))
                    .foregroundStyle(Color(hex: "898F97"))
                    .padding(.bottom, 28)
            }
            AudioControlsView
            
        }
        .padding(.vertical, 100)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if let image = viewModel.data?.image {
                    Image(image)
                        .resizable()
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(.ultraThinMaterial.opacity(0.5))
                            .frame(height: 100)
                            .blur(radius: 20)
                    }
                }
            }
        )
    }
}
