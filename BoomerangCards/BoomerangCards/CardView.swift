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
    CardModel(name: "Michael Smith", expirationDate: "11/27", lastDigits: "9214", gradient: [Color.blue, Color.green], companyName: "QuantumPay"),
    CardModel(name: "Emily Davis", expirationDate: "08/22", lastDigits: "6732", gradient: [Color.purple, Color.pink], companyName: "LunaCard"),
    CardModel(name: "David Wilson", expirationDate: "06/19", lastDigits: "5489", gradient: [Color.yellow, Color.green], companyName: "NovaBank"),
    CardModel(name: "Sophia Brown", expirationDate: "12/23", lastDigits: "1763", gradient: [Color.orange, Color.red], companyName: "AuroraPay"),
    CardModel(name: "Olivia Lee", expirationDate: "09/25", lastDigits: "7921", gradient: [Color.green, Color.yellow], companyName: "OrbitCard"),
    CardModel(name: "James Taylor", expirationDate: "04/28", lastDigits: "4567", gradient: [Color.pink, Color.purple], companyName: "SkyBank"),
    CardModel(name: "Emma Harris", expirationDate: "07/21", lastDigits: "2310", gradient: [Color.blue, Color.red], companyName: "SolarPay"),
    CardModel(name: "Benjamin Clark", expirationDate: "02/26", lastDigits: "9876", gradient: [Color.orange, Color.yellow], companyName: "GalaxyCard"),
    CardModel(name: "Ava Martinez", expirationDate: "05/29", lastDigits: "5432", gradient: [Color.green, Color.purple], companyName: "StarPay"),
    CardModel(name: "William Anderson", expirationDate: "10/20", lastDigits: "1234", gradient: [Color.pink, Color.orange], companyName: "UniverseCard"),
    CardModel(name: "Mia White", expirationDate: "01/30", lastDigits: "8901", gradient: [Color.red, Color.blue], companyName: "CosmoBank"),
    CardModel(name: "Ethan Walker", expirationDate: "08/27", lastDigits: "5678", gradient: [Color.yellow, Color.purple], companyName: "SolarCard"),
    CardModel(name: "Isabella Turner", expirationDate: "11/22", lastDigits: "4321", gradient: [Color.blue, Color.green], companyName: "OrbitPay"),
    CardModel(name: "Liam King", expirationDate: "06/26", lastDigits: "6543", gradient: [Color.orange, Color.red], companyName: "GalaxyPay")
]

