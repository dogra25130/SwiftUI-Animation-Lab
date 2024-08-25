//
//  PodcastPlayer.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
import AVKit

struct PodcastPlayer: View {
    @StateObject var viewModel: PodCastViewModel
    @State var player: AVPlayer?
    @State var isPlaying = false
    @State var totalTime: TimeInterval = 0.0
    @State var currentTime: TimeInterval = 0.0
    
    var body: some View {
        VStack(spacing: .zero) {
            PodcastHeaderView
            VStack {
                PlayerSlider(player: $player, isPlaying: $isPlaying,
                             totalTime: $totalTime, currentTime: $currentTime)
                    .padding(.bottom, 12)
                AudioInfoView
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundStyle(Color.gray)
                    .padding(.horizontal)
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            .background(UnevenRoundedRectangle(topLeadingRadius: 16,
                                               bottomLeadingRadius: .zero,
                                               bottomTrailingRadius: .zero,
                                               topTrailingRadius: 16,
                                               style: .circular)
                .fill(Color.black)
            .offset(y: -20))
            PodcastScrollableContentView
            
        }
        .opacity(viewModel.data.isNil ? 0 : 1)
        .ignoresSafeArea(edges: .bottom)
        .background(Color.black)
        .toolbar(.hidden, for: .automatic)
        .applyPodCastShimmerView(isLoading: viewModel.data.isNil)
        .task {
            await viewModel.fetchData()
            if let audioUrl = viewModel.data?.url,
               let path = Bundle.main.path(forResource: audioUrl, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                player = AVPlayer(url: url)
                
                let duration = (try? await player?.currentItem?.asset.load(.duration)) ?? .zero
                totalTime = CMTimeGetSeconds(duration)
                
                player?.play()
                isPlaying = true
            }
        }
    }
}
