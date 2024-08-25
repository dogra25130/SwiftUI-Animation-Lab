//
//  PodcastAView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var AudioInfoView: some View {
        HStack {
            
            Button {
                viewModel.updateLikeDislikeStatus(status: .like)
            } label: {
                Image(systemName: "hand.thumbsup.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(viewModel.likeDislikeStatus == .like ? Color.green : Color.gray,
                                     Color(hex: "459221").opacity(0.15))
            }
            .addBounceButtonStyle()
            
            Text(viewModel.getLikeCount())
                .foregroundStyle(Color.white)
                .font(.setFont(.regular400, 12))
                .frame(width: 50)
            
            Spacer()
            Text("\(getCurrentDuration()) / \(getTotalDuration())")
                .foregroundStyle(Color.white)
                .font(.setFont(.medium500, 14))
            Spacer()
            
            Text(viewModel.getDislikeCount())
                .foregroundStyle(Color.white)
                .font(.setFont(.regular400, 12))
                .frame(width: 50)
            Button {
                viewModel.updateLikeDislikeStatus(status: .dislike)
            } label: {
                Image(systemName: "hand.thumbsdown.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(viewModel.likeDislikeStatus == .dislike ? Color.red : Color.gray,
                                     Color.red.opacity(0.15))
            }
            .addBounceButtonStyle()
        }
        .padding(.bottom, 12)
    }
    
    private func getCurrentDuration() -> String {
        return formatTime(seconds: Int(currentTime * totalTime))
    }
    
    func getTotalDuration() -> String {
        return formatTime(seconds: Int(totalTime))
    }
                          
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
