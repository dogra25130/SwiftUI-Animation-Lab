//
//  RecipesCollectionView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 12/06/23.
//

import SwiftUI

struct RecipesCollectionView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(recipesData) { recipe in
                RecipeCardView(recipe: recipe)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct RecipesCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesCollectionView()
    }
}
