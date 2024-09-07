//
//  PodcastHeaderLabelView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    
    var PodcastHeaderLabelView: some View {
        HStack(alignment: .center) {
            if let count = viewModel.data?.episodes.count {
                Text("Episodes (\(count))")
                    .foregroundStyle(Color.white)
                    .font(.setFont(.medium500, 16))
            }
        }
        .padding(.bottom, 18)
    }
}
