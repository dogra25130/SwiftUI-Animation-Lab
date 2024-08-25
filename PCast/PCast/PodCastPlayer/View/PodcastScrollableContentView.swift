//
//  ScrollableContentView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var PodcastScrollableContentView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CurrentPodcastInfoView
                CurrentPodCastDescView
                PodcastHeaderLabelView
                ForEach(viewModel.data?.episodes ?? []) { episode in
                    PodcastCellView(for: episode)
                        .padding(.bottom, 8)
                }
            }
            .padding(.top, 32)
        }
        .ignoresSafeArea(edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .scrollIndicators(.hidden)
    }
}
