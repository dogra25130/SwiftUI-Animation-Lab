//
//  Card.swift
//  BoomerangCards
//
//  Created by Abhishek Dogra on 08/10/23.
//

import SwiftUI

struct CardView: View {
    let model: CardModel
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(model.companyName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
            }
            .padding(20)
            
            
            HStack {
                Text("Card Number:")
                    .foregroundColor(.white)
                Spacer()
                Text("**** **** **** \(model.lastDigits)")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("Cardholder Name:")
                    .foregroundColor(.white)
                Spacer()
                Text(model.name)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("Expires:")
                    .foregroundColor(.white)
                Spacer()
                Text(model.expirationDate)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
        }
        .frame(width: 300, height: 200)
        .background(LinearGradient(gradient: Gradient(colors: model.gradient), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardModel(name: "A", expirationDate: "A", lastDigits: "A", gradient: [.red, .blue], companyName: "A"))
    }
}

struct CardModel {
    let name: String
    let expirationDate: String
    let lastDigits: String
    let gradient: [Color]
    let companyName: String
}

let cardModel: [CardModel] = [
    CardModel(name: "Alice Johnson", expirationDate: "03/24", lastDigits: "3857", gradient: [Color.red, Color.orange], companyName: "StarCard"),
    CardModel(name: "Michael Smith", expirationDate: "11/27", lastDigits: "9214", gradient: [Color.blue, Color.green], companyName: "QuantumPay"),
    CardModel(name: "Emily Davis", expirationDate: "08/22", lastDigits: "6732", gradient: [Color.purple, Color.pink], companyName: "LunaCard"),
    CardModel(name: "David Wilson", expirationDate: "06/19", lastDigits: "5489", gradient: [Color.yellow, Color.green], companyName: "NovaBank"),
    CardModel(name: "Sophia Brown", expirationDate: "12/23", lastDigits: "1763", gradient: [Color.orange, Color.red], companyName: "AuroraPay")
]
