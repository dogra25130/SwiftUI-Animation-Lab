//
//  VideoPlayerHelper.swift
//  Africa
//
//  Created by Abhishek Dogra on 04/06/23.
//

import AVKit
import Foundation

var videoPlayer: AVPlayer?
func playVideo(fileName: String, fileFormat: String) -> AVPlayer {
    if let url = Bundle.main.url(forResource: fileName, withExtension: fileFormat) {
        videoPlayer = AVPlayer(url: url)
        videoPlayer?.play()
    }
    return videoPlayer!
}
