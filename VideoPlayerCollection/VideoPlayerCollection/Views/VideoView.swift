//
//  VideoView.swift
//  VideoPlayerCollection
//
//  Created by Abhishek Dogra on 06/09/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var video: Video
    @State var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if let link = video.videoFiles.first?.link {
                    player = AVPlayer(url: URL(string: link)!)
                    player.play()
                }
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: previwVideo)
    }
}
