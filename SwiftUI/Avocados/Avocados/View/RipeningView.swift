//
//  RipeningView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RipeningView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 25) {
                    ForEach(ripeningData) { data in
                        RipeningBaseView(ripeData: data)
                    }
                }
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 25)
        }
        
    }
}

struct RipeningView_Previews: PreviewProvider {
    static var previews: some View {
        RipeningView()
    }
}
