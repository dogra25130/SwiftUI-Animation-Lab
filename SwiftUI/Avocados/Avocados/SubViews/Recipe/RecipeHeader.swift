//
//  RecipeHeader.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RecipeHeader: View {
    let header: [Header] = headersData
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(header) { head in
                    RecipeHeaderContent(header: head)
                }
            }
        }
    }
}

struct RecipeHeader_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHeader()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
