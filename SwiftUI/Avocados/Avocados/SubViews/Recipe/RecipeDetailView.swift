//
//  RecipeDetailView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 12/06/23.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 5) {
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                RecipeSectionHeader(title: recipe.title)
                HStack {
                    ForEach(0..<recipe.rating, id: \.self) {_ in
                            Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                    }
                }
                
                HStack(alignment: .center, spacing: 12) {
                  HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "person.2")
                    Text("Serves: \(recipe.serves)")
                  }
                  HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "clock")
                    Text("Prep: \(recipe.preparation)")
                  }
                  HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "flame")
                    Text("Cooking: \(recipe.cooking)")
                  }
                }
                .font(.footnote)
                .foregroundColor(Color.gray)
                
                
                RecipeSectionHeader(title: "Ingredients")
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.footnote)
                        Divider()
                    }
                }
                .padding(.horizontal, 20)
                
                
                RecipeSectionHeader(title: "Instructions")
                ForEach(recipe.instructions, id: \.self) { instruction in
                    VStack {
                        Image(systemName: "chevron.down.circle")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .font(Font.title.weight(.ultraLight))
                            .foregroundColor(Color("ColorGreenAdaptive"))
                        Text(instruction)
                            .multilineTextAlignment(.center)
                            .font(.system(.body, design: .serif))
                            .frame(minHeight: 100)
                    }
                    .padding(.horizontal, 24)
                }
                
                Spacer()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: recipesData[0])
    }
}
