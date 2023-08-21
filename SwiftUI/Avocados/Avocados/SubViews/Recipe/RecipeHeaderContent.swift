//
//  RecipeHeaderContent.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RecipeHeaderContent: View {
    var header: Header
    var body: some View {
        ZStack {
            Image(header.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(Color("ColorGreenLight"))
                    .frame(width: 4)
                VStack(alignment: .leading, spacing: 6) {
                    Text(header.headline)
                        .font(.system(.headline, design: .serif))
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .shadow(radius: 3)
                    
                    Text(header.subheadline)
                        .font(.footnote)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                }
                .padding(.vertical, 0)
                .padding(.horizontal, 20)
                .frame(width: 281, height: 105)
                .background(Color("ColorBlackTransparentLight"))
            }
            .frame(width: 285, height: 105, alignment: .center)
            .offset(x: -66, y: 75)
        }
        .frame(width: 480, height: 300, alignment: .center)
    }
}

struct RecipeHeaderContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHeaderContent(header: headersData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
