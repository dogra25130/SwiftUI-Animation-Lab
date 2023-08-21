//
//  FactsView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct FactsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(factsData) { data in
                    FactsDetailView(fact: data)
                }
            }
            .padding(.leading, 30)
        }
        
        
    }
}

struct FactsView_Previews: PreviewProvider {
    static var previews: some View {
        FactsView()
    }
}
