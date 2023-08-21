//
//  QuanitiyFavouriteDetailView.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 10/06/23.
//

import SwiftUI

struct QuanitiyFavouriteDetailView: View {
    @State private var counter: Int = 0
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            Button {
                if counter > 0 {
                    counter -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
                    .frame(minWidth: 36)
            }
            Text("\(counter)")
            Button {
                counter += 1
            } label: {
                Image(systemName: "plus.circle")
                    .frame(minWidth: 36)
            }
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "heart.circle")
                    .foregroundColor(.pink)
            }

        }
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
    }
}

struct QuanitiyFavouriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuanitiyFavouriteDetailView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
