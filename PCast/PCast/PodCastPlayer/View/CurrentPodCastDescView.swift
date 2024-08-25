//
//  PodcastDescView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var CurrentPodCastDescView: some View {
        Text(viewModel.data?.episodeInfo.desc ?? "")
            .lineLimit(4)
            .foregroundStyle(Color(hex: "898F97"))
            .padding(.bottom, 32)
            .font(.setFont(.regular400, 14))
    }
}
