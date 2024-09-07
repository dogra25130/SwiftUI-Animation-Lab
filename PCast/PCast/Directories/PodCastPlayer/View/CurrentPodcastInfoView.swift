//
//  CurrentPodcastInfoView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var CurrentPodcastInfoView: some View {
        HStack(spacing: 12) {
            if let title = viewModel.data?.episodeInfo.episodeTitle,
               let size = viewModel.data?.episodeInfo.size {
            Image(systemName: "waveform")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(Color.white)
                .padding(8)
                .background(
                    Circle()
                        .fill(Color(hex: "19232F"))
                    
                )
            
                Text(title)
                    .font(.setFont(.regular400, 14))
                    .foregroundStyle(Color.white)
                    .padding(.trailing, 12)
                
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.white)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color(hex: "19232F"))
                        
                    )
                
                
                Text(size)
                    .font(.setFont(.regular400, 14))
                    .foregroundStyle(Color.white)
                
                Spacer()
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 16, height: 4)
                    .foregroundStyle(Color.white)
                    .rotationEffect(.degrees(90))
            }
        }
        .padding(.bottom, 32)
    }
}
