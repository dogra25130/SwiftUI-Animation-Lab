//
//  RipeBaseView.swift
//  Avocados
//
//  Created by Abhishek Dogra on 17/06/23.
//

import SwiftUI

struct RipeningBaseView: View {
    var ripeData: Ripening
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Text("\(ripeData.stage)")
                    .font(.system(.largeTitle, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                    .padding(.top, 50)
                
                Text("Stage".uppercased())
                    .font(.system(.subheadline, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                
                Text("\(ripeData.title)")
                    .font(.system(.title, design: .serif))
                    .foregroundColor(Color("ColorGreenMedium"))
                    .fontWeight(.bold)
                    .frame(width: 220)
                    .padding(.vertical, 12)
                    .background(
                      RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("ColorGreenLight")]), startPoint: .top, endPoint: .bottom))
                      .shadow(color: Color("ColorBlackTransparentLight"), radius: 6, x: 0, y: 6)
                    )
                
                Text("\(ripeData.description)")
                    .font(.system(.subheadline, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenDark"))
                    .padding(20)
                
                Text("\(ripeData.ripeness.uppercased())")
                    .foregroundColor(Color.white)
                    .font(.system(.callout, design: .serif))
                    .fontWeight(.bold)
                    .shadow(radius: 3)
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    .frame(width: 185)
                    .background(
                      RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorGreenMedium"), Color("ColorGreenDark")]), startPoint: .top, endPoint: .bottom))
                      .shadow(color: Color("ColorBlackTransparentLight"), radius: 6, x: 0, y: 6)
                    )
                
                Text(ripeData.instruction)
                  .font(.footnote)
                  .foregroundColor(Color("ColorGreenLight"))
                  .fontWeight(.bold)
                  .lineLimit(3)
                  .frame(width: 160)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .frame(width: 260, height: 485, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color("ColorGreenLight"), Color("ColorGreenMedium")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            ZStack {
                Circle()
                    .stroke(.white, lineWidth: 20)
                Circle()
                    .stroke(Color("ColorGreenLight"), lineWidth: 10)
                Image(ripeData.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())

            }
            .frame(width: 100, height: 100, alignment: .center)
            .offset(y: -250)
        }
    }
}

struct RipeningBaseView_Previews: PreviewProvider {
    static var previews: some View {
        RipeningBaseView(ripeData: ripeningData[0])
    }
}
