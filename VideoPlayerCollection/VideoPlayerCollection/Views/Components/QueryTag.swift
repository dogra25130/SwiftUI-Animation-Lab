//
//  QueryTag.swift
//  VideoPlayerCollection
//
//  Created by Abhishek Dogra on 06/09/23.
//

import SwiftUI

struct QueryTag: View {
    var query: Query
    var isSelected: Bool
    var body: some View {
        
        Text(query.rawValue)
            .textCase(.uppercase)
            .font(.caption)
            .bold()
            .foregroundColor(isSelected ? .black : .gray)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
    }
}

struct QueryTag_Previews: PreviewProvider {
    static var previews: some View {
        QueryTag(query: .nature, isSelected: true)
    }
}
