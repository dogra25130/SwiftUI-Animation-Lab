//
//  RecipeCardView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 12/06/23.
//

import SwiftUI

struct RecipeCardView: View {
    @State private var showModal: Bool = false
    let recipe: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(recipe.image)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 12) {
                Text(recipe.title)
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                    .lineLimit(1)
                
                Text(recipe.headline)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(Color.gray)
                    .italic()
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
            }
            .padding()
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
        .padding(10)
        .onTapGesture {
            self.showModal = true
        }
        .sheet(isPresented: self.$showModal) {
            RecipeDetailView(recipe: self.recipe)
        }
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeCardView(recipe: recipesData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
