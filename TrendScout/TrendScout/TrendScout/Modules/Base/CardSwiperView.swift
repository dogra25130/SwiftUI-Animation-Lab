//
//  CardSwiperView.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 30/07/24.
//

import SwiftUI

struct SwipeableCardsView: View {
    @State private var currentIndex = 0
    @State private var tappedIndex: Int? = nil
    @State private var backgroundColors: [Color] = []
    let cardsDetails: [CardDetail] = [
        CardDetail(
            title: "Global Solutions",
            imageURL: "1",
            finalPrice: "$759.00",
            price: "$730.00",
            aspectRatio: 1.5,
            ratings: 4.8,
            backgroundColors: [Color(hex: "#FFFFFF"), Color(hex: "D8BFD8"), Color(hex: "BA55D3")]
        ),
        CardDetail(
            title: "Tech Innovations",
            imageURL: "4",
            finalPrice: "$899.99",
            price: "$850.50",
            aspectRatio: 1.25,
            ratings: 4.7,
            backgroundColors: [Color(hex: "#FFFFFF"), Color(hex: "BFC9CA"), Color(hex: "2C3E50")]
        ),
        CardDetail(
            title: "Apex Industries",
            imageURL: "3",
            finalPrice: "$649.50",
            price: "$620.00",
            aspectRatio: 1,
            ratings: 4.6,
            backgroundColors: [Color(hex: "#FFFFFF"), Color(hex: "C0C0C0"), Color(hex: "8B4513")]
        ),
        CardDetail(
            title: "Prime Enterprises",
            imageURL: "5",
            finalPrice: "$499.99",
            price: "$470.00",
            aspectRatio: 1,
            ratings: 4.5,
            backgroundColors: [Color(hex: "FFFFFF"), Color(hex: "A9A9A9"), Color(hex: "778899")]
        ),
        CardDetail(
            title: "Dynamic Networks",
            imageURL: "6",
            finalPrice: "$850.00",
            price: "$800.00",
            aspectRatio: 1,
            ratings: 4.9,
            backgroundColors: [Color(hex: "#FFFFFF"), Color(hex: "8D8D8D"), Color(hex: "6C4F4F")]
        )
    ]
    var body: some View {
        
        VStack {
            ZStack {
                LinearGradient(colors: cardsDetails[safe: currentIndex]?.backgroundColors ?? cardsDetails[ 0].backgroundColors,
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: .zero) {
                    VStack(alignment: .leading) {
                        Text("Exquisite Tech Treasures")
                            .font(.setFont(.bold700, .p32))
                        Text("Indulge in the Pinnacle of Luxury and Innovation")
                            .font(.setFont(.regular400, .p16))
                    }
                    .foregroundStyle(.black)
                    .padding(.p32)
                    .transition(.slide)
                     
                    CardStack(cardsDetails, currentIndex: $currentIndex) { cardsDetail in
                        Image(cardsDetail.imageURL)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(cardsDetail.title)
                                            .font(.setFont(.bold700, 24))
                                        
                                        Text(cardsDetail.finalPrice)
                                            .font(.setFont(.medium500, .p16))
                                    }
                                    .foregroundStyle(Color.white)
                                    .shadow(color: Color(hex: "000000"), radius: .p10)
                                    .padding()
                                    Spacer()
                                }
                            }
                            .shadow(color: Color(hex: "E6E6FA"), radius: 10)
                            .frame(height: 350)
                            .padding(75)
                    }
                }
            }
        }
    }
}
struct DemoItem: Identifiable {
    let name: String
    let color: Color
    
    var id: String {
        name
    }
}

#Preview {
    SwipeableCardsView()
}
