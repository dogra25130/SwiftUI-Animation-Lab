//
//  VideoPlayerView.swift
//  Africa
//
//  Created by Abhishek Dogra on 04/06/23.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    let videoSelected: String
    let videoTitle: String
    var body: some View {
        VStack {
            VideoPlayer(player: playVideo(fileName: videoSelected, fileFormat: "mp4")) {
                
            }
            .overlay (
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.top, 6)
                    .padding(.horizontal, 8)
                , alignment: .topLeading
            )
        }
        .foregroundColor(.accentColor)
        .navigationBarTitle(videoTitle, displayMode: .inline)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static let videos: [Video] = Bundle.main.decode("videos.json")
    static var previews: some View {
        VideoPlayerView(videoSelected: "cheetah", videoTitle: "Cheetah")
    }
}
