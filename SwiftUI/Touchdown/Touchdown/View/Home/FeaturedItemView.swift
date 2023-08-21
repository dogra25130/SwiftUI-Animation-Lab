//
//  FeaturedItemView.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import SwiftUI

struct FeaturedItemView: View {
    let player: Player
    var body: some View {
        Image(player.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct FeaturedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItemView(player: players[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
