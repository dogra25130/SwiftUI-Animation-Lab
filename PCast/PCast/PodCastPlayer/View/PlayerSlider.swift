//
//  File.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
import AVKit

struct PlayerSlider: View {
    @Binding var player: AVPlayer?
    @Binding var isPlaying: Bool
    @Binding var totalTime: TimeInterval
    @Binding var currentTime: TimeInterval
    @State private var totalWidth: CGFloat = .zero
    private let thumbRadius: CGFloat = 9
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white)
                    .frame(width: geometry.size.width, height: 4)
                    .onTapGesture(coordinateSpace: .local) { location in
                        updateValue(with: location.x, in: geometry)
                    }
                
                Capsule()
                    .fill(Color.blue)
                    .frame(width: currentTime * geometry.size.width, height: 4)
                    .onTapGesture(coordinateSpace: .local) { location in
                        updateValue(with: location.x, in: geometry)
                    }
                
                Circle()
                    .fill(Color.white)
                    .stroke(Color.blue, lineWidth: 8)
                    .frame(width: thumbRadius * 2)
                    .offset(x: currentTime * geometry.size.width - thumbRadius)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ gesture in
                                updateValue(with: gesture.location.x, in: geometry)
                            })
                    )
            }
            .onAppear {
                totalWidth = geometry.size.width
            }
        }
        .frame(height: 20)
        .onDisappear {
            player?.pause()
            isPlaying = false
            player = nil
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
        
    }
    
    private func updateProgress() {
        guard let player, isPlaying, totalTime > 0.0 else { return }
        currentTime = CMTimeGetSeconds(player.currentTime()) / totalTime
    }
    
    private func updateValue(with xPosition: CGFloat, in geometry: GeometryProxy) {
        var dragPortion = xPosition / geometry.size.width
        dragPortion = min(dragPortion, 1)
        dragPortion = max(dragPortion, 0)
        currentTime = dragPortion
        let seekTime = CMTime(seconds: currentTime * totalTime, preferredTimescale: 1)
        player?.seek(to: seekTime)
    }
}
