//
//  ContentView.swift
//  ParallaxSlider
//
//  Created by Abhishek Dogra on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    @State var selected: Int = 0
    @State private var title: String = ""
    @State private var desc: String = ""
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text(animals[selected].title)
                    .id(animals[selected].title)
                    .transition(.opacity.animation(.linear))
                    .foregroundColor(.white)
                    .font(.title)
                TabView(selection: $selected) {
                    ForEach(animals, id: \.id) { animal in
                        GeometryReader { reader in
                            Image("p\(animal.id + 1)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(x: -reader.frame(in: .global).minX)
                                .frame(width: width, height: height / 2)
                        }
                        .cornerRadius(15)
                        .padding()
                    }
                }
                .scaledToFit()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                Text(animals[selected].desc)
                    .id(animals[selected].desc)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .transition(.opacity.animation(.linear))
                    .padding()
                    .font(.body)
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AnimalData: Identifiable {
    let id: Int
    let title: String
    let desc: String
}

let animals: [AnimalData] = [AnimalData(id: 0, title: "Lion", desc: "The lion, Panthera leo, reigns as a symbol of strength and majesty in the animal kingdom. With its imposing golden-yellow coat and impressive mane, the lion commands attention and reverence. Roaming the grassy savannas of Africa, these social felines exhibit a unique group dynamic. The females, skilled hunters, work together to bring down prey, while the males' iconic manes both protect and adorn them."),
                             AnimalData(id: 1, title: "African buffalo", desc:
                    "The African buffalo, scientifically known as Syncerus caffer, is a formidable and resilient creature that inhabits the diverse landscapes of sub-Saharan Africa. As one of the continent's most iconic large mammals, the African buffalo holds a prominent place in both the natural world and human cultures."),
                             AnimalData(id: 2, title: "Giraffe", desc: "The giraffe, Giraffa camelopardalis, stands as one of the most recognizable and extraordinary creatures on the African savannas. With its towering neck, distinctive coat pattern, and gracefully elongated legs, the giraffe is a symbol of unique beauty and adaptability in the animal kingdom."),
                             AnimalData(id: 3, title: "Hippopotamus", desc: "The hippopotamus, Hippopotamus amphibius, is a remarkable and enigmatic aquatic mammal that resides in the rivers, lakes, and swamps of sub-Saharan Africa. Despite its seemingly slow and ponderous nature, the hippopotamus is considered one of the most dangerous animals on the continent due to its unpredictable behavior and immense size.")]
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
