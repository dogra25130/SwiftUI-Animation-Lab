//
//  AudioControlsView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    var AudioControlsView: some View {
        HStack(spacing: 32) {
            Button {
                
            } label: {
                Image(systemName: "arrowshape.turn.up.left")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.white)
            }
            .addBounceButtonStyle()
            
            Button {
                if isPlaying { player?.pause() }
                else { player?.play() }
                
                withAnimation {
                    isPlaying.toggle()
                }
            } label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(Color.white)
                    .foregroundStyle(Color.red)
                    .clipShape(Circle())
            }
            .addBounceButtonStyle()
            
            Button {
                
            } label: {
                Image(systemName: "arrowshape.turn.up.right")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.white)
            }
            .addBounceButtonStyle()
        }
    }
}
