//
//  RecipeSectionHeader.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RecipeSectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(.title, design: .serif))
            .foregroundColor(Color("ColorGreenMedium"))
            .fontWeight(.bold)
            .padding(.vertical, 20)
    }
}

struct RecipeSectionHeader_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeSectionHeader(title: "Avocado Dishes")
    }
}
