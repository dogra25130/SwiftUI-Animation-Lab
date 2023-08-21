//
//  RecipesView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                RecipeHeader()
                RecipeSectionHeader(title: "Avocado Dishes")
                RecipeDishes()
                RecipeSectionHeader(title: "Avocado Facts")
                FactsView()
                RecipeSectionHeader(title: "Avocado Recipes")
                RecipesCollectionView()
                RecipeSectionHeader(title: "All about Avocados")
                Text("Everything you wanted to know about avocados but were too afraid to ask.")
                    .font(.system(.callout, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: 640)
            .padding(.bottom, 95)
        }
        .padding(.bottom, 0)
        .edgesIgnoringSafeArea(.all)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
