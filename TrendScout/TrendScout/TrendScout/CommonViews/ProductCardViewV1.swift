//
//  ProductCardViewV1.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 27/07/24.
//

import SwiftUI
struct ProductCardViewV1: View {
    let data: CardDetail
    var aspectRatio: CGFloat = 2.0
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(data.imageURL)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: .p24))
                    .aspectRatio(aspectRatio, contentMode: .fill)
                VStack {
                    RatingsView(ratings: data.ratings)
                    Spacer()
                }
            }
            .zIndex(2)
            ProductInfoView(data: data)
                .offset(y: -.p20)
                .zIndex(1)
        }
        
    }
}

struct RatingsView: View {
    let ratings: CGFloat
    @State private var isSelected = false

    var body: some View {
        HStack {
            ZStack {
                
                HStack {
                    Text(ratings.description)
                        .foregroundStyle(Color.white)
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)
                }
                .font(.setFont(.regular400, .p12))
                .padding(.p6)
                .background(
                    Color.black.opacity(0.3)
                )
                
            }
            .fixedSize()
            .frame(height: .p20)
            .clipShape(RoundedRectangle(cornerRadius: .p8))
            
            Spacer()
            
            Image(systemName: isSelected ? "heart.fill" : "heart")
                .shadow(color: isSelected ? Color.white : Color.clear, radius: 2)
                .symbolEffect(.bounce, value: isSelected)
                .foregroundStyle(isSelected ? Color.pink : Color.white)
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                    }
                }
        }
        .padding()
    }
}

struct ProductInfoView: View {
    let data: CardDetail
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.setFont(.medium500, .p18))
                    .lineLimit(2)
                    .padding(.top)
                HStack(alignment: .center) {
                    Text(data.finalPrice)
                        .font(.setFont(.semiBold600, .p16))
                    
                    Text(data.price)
                        .font(.setFont(.light300, .p10))
                        .strikethrough()
                        .bold()
                    
                    Spacer()
                    
                }
            }
            .foregroundStyle(Utils.textTheme)
            .padding()
            
        }
    }
}

#Preview(body: {
    HomeScreen()
})
