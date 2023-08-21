//
//  FactsView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct FactsDetailView: View {
    let fact: Fact
    var body: some View {
        ZStack {
            
            Text(fact.content)
              .padding(.leading, 55)
              .padding(.trailing, 10)
              .padding(.vertical, 3)
              .frame(width: 300, height: 135, alignment: .center)
              .background(LinearGradient(gradient: Gradient(colors: [Color("ColorGreenMedium"), Color("ColorGreenLight")]), startPoint: .leading, endPoint: .trailing))
              .cornerRadius(12)
              .lineLimit(6)
              .multilineTextAlignment(.leading)
              .font(.footnote)
              .foregroundColor(Color.white)

            ZStack {
                
                Circle()
                    .stroke(.white, lineWidth: 20)
                
                Circle()
                    .stroke(LinearGradient(colors: [Color("ColorGreenLight"), Color("ColorGreenMedium")],
                                           startPoint: .leading,
                                           endPoint: .trailing), lineWidth: 10)
                
                Image(fact.image)
                    .resizable()
                    .clipShape(Circle())
                
            }
            .frame(width: 66, height: 66)
            .offset(x: -150)
        }
        .frame(width: 350, height: 150)
    }
}

struct FactsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FactsDetailView(fact: factsData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
