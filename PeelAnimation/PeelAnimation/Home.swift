//
//  Home.swift
//  PeelAnimation
//
//  Created by Abhishek Dogra on 15/09/23.
//

import SwiftUI

struct Home: View {
    @State private var data = dataModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                ForEach(data) { asset in
                    PeelEffect(content: {
                        CardView(asset)

                    }, onDelete: {
                        
                    }, couponCode: asset.couponCode)
                }
            }
            .padding(15)
        }
    }
    
    @ViewBuilder
    func CardView(_ dataModel: DataModel) -> some View {
        GeometryReader { _ in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(dataModel.assetName)
                    .overlay {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(dataModel.discountPercentage)
                                    .font(.title)
                                    .fontWeight(.black)
                                Text(dataModel.name)
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 10) {
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                Text("Swipe here")
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        
                    }
            }
        }
        .frame(height: 130)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DataModel: Identifiable {
    var id: UUID = .init()
    var assetName: Color
    var couponCode: String
    var discountPercentage: String
    var name: String
}

var dataModel: [DataModel] = [
    DataModel(assetName: Color(hex: "FF5733"), couponCode: "FF5733", discountPercentage: "10% off", name: "Foodie Fleet"),
    DataModel(assetName: Color(hex: "4CAF50"), couponCode: "4CAF50", discountPercentage: "40% off", name: "Style Stream"),
    DataModel(assetName: Color(hex: "2196F3"), couponCode: "2196F3", discountPercentage: "30% off", name: "Pet Palace"),
    DataModel(assetName: Color(hex: "FFC107"), couponCode: "FFC107", discountPercentage: "50% off", name: "Eco Savers"),
    DataModel(assetName: Color(hex: "9C27B0"), couponCode: "9C27B0", discountPercentage: "20% off", name: "Joy Ride")
]

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
