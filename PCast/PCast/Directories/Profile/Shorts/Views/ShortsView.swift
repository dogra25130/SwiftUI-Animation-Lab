//
//  ReelsView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/09/24.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    let id = UUID().uuidString
    var url: URL
}

@MainActor
class VideoPlayerItem: Identifiable {
    let id = UUID().uuidString
    var player: AVQueuePlayer
    var playerLooper: AVPlayerLooper?
    
    init(videoURL: URL) {
        let asset = AVAsset(url: videoURL)
        let item = AVPlayerItem(asset: asset)
        
        player = AVQueuePlayer(playerItem: item)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }
    
    func update(videoURL: URL) {
        
        let asset = AVAsset(url: videoURL)
        let item = AVPlayerItem(asset: asset)
        
        player.replaceCurrentItem(with: item)
        playerLooper = nil
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }
}

struct ReelsView: View {
    @State var players: [VideoPlayerItem] = []
    @State var currentVisibleIndex: Int = 0
    @State var currentOffset: CGFloat = 0.0
    @State var reels = reelsModelData.map { item -> Reel in
        let url = Bundle.main.url(forResource: item.url, withExtension: "mp4")!
        return Reel(url: url)
    }

    func isScrolledUp(oldValue: CGFloat, newValue: CGFloat) -> Bool {
        if (oldValue == 0.0 || oldValue == 1.0) && newValue == 1/3 {
            return true
        }else if oldValue == 1/3 && newValue == 2/3 {
            return true
        }else if oldValue == 2/3 && (newValue == 0.0 || newValue == 1.0) {
            return true
        }
        return false
    }
    func isScrolledDown(oldValue: CGFloat, newValue: CGFloat) -> Bool {
        if (newValue == 0.0 || newValue == 1.0) && oldValue == 1/3 {
            return true
        }else if newValue == 1/3 && oldValue == 2/3 {
            return true
        }else if newValue == 2/3 && (oldValue == 0.0 || oldValue == 1.0) {
            return true
        }
        return false
    }
    
    func updateVideo() {
        let currentPlayerIndex = (currentVisibleIndex + players.count) % players.count
        players[currentPlayerIndex].player.play()
        
        let nextPlayerIndex = (currentVisibleIndex + 1 + players.count) % players.count
        let nextVideoIndex = (currentVisibleIndex + 1 + reels.count) % reels.count
        players[nextPlayerIndex].update(videoURL: reels[nextVideoIndex].url)
        players[nextPlayerIndex].player.pause()
        
        let prevPlayerIndex = (currentVisibleIndex - 1 + players.count) % players.count
        let prevVideoIndex = (currentVisibleIndex - 1 + reels.count) % reels.count
        players[prevPlayerIndex].update(videoURL: reels[prevVideoIndex].url)
        players[prevPlayerIndex].player.pause()
    }
    
    var body: some View {
        GeometryReader { proxy in
            LoopingScrollView(height: proxy.size.height,
                              items: players,
                              offset: $currentOffset) { item in
                VideoPlayer(player: item.player)
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .ignoresSafeArea()
            }
            .scrollTargetBehavior(.paging)
        }
        .ignoresSafeArea()
        .onChange(of: currentOffset) { oldValue, newValue in
            if isScrolledUp(oldValue: oldValue, newValue: newValue) {
                currentVisibleIndex += 1
                updateVideo()
            }else if isScrolledDown(oldValue: oldValue, newValue: newValue) {
                currentVisibleIndex -= 1
                updateVideo()
            }
        }
        .task {
            players = [VideoPlayerItem(videoURL: Bundle.main.url(forResource: "video_1", withExtension: "mp4")!),
            VideoPlayerItem(videoURL: Bundle.main.url(forResource: "video_2", withExtension: "mp4")!),
            VideoPlayerItem(videoURL: Bundle.main.url(forResource: "video_3", withExtension: "mp4")!)]
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                updateVideo()
            }
        }
    }
}

extension AVPlayerViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.showsPlaybackControls = false
    }
}

#Preview {
    ReelsView()
}
