//
//  ItemView.swift
//  Learn by Doing
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI
import AVKit
var audioPlayer: AVAudioPlayer?

func playSound() {
  if let path = Bundle.main.path(forResource: "sound-chime", ofType: "mp3") {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Could not find and play the sound file.")
    }
  }
}

struct ItemView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            Image(card.imageName)
            
            VStack(spacing: 5) {
                Text(card.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                Text(card.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .italic()
                
            }
            .offset(y: -210)
            
            
            Button {
                playSound()

            } label: {
                    HStack {
                        Text(card.callToAction.uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 24)
                    .background(LinearGradient(gradient: Gradient(colors: card.gradientColors),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .clipShape(Capsule())
                    .shadow(color: Color("ColorShadow"), radius: 6, x: 0, y: 3)
            }
            .offset(y: 210)

        }
        .frame(width: 335, height: 545)
        .background(Gradient(colors: card.gradientColors), ignoresSafeAreaEdges: .all)
        .cornerRadius(16)
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(card: cardData[0])
            .previewLayout(.sizeThatFits)
        
    }
}
