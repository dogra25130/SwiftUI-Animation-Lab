//
//  BrandView.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import SwiftUI

struct BrandView: View {
    let brand: Brand
    var body: some View {
        HStack(spacing: 0) {
            Image(brand.image)
                .resizable()
                .scaledToFit()
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                        .background(.white)
                )
        }
        

    }
}

struct BrandView_Previews: PreviewProvider {
    static var previews: some View {
        BrandView(brand: brands[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
