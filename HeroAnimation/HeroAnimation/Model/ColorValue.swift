//
//  ColorValue.swift
//  HeroAnimation
//
//  Created by Abhishek Dogra on 10/09/23.
//

import Foundation
import SwiftUI

struct ColorValue: Identifiable, Hashable, Equatable {
    var id: UUID = .init()
    var colorCode: String
    var title: String
    var subtitle: String
    var source: String
    var image: UIImage
    var description: [String]
    var color: Color {
        Color(hex: colorCode)
    }
}

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
var colors: [ColorValue] = [
    ColorValue(colorCode: "#0077BE", title: "Antarctic Silence", subtitle: "Deepest Quiet", source: "Nature", image: UIImage(named: "Image 1")!, description: [
        "In Antarctica, the world's quietest place,",
        "Sound can travel for miles due to its dry,",
        "Cold air. The serene silence is so profound",
        "That it can be unsettling, making it an ideal",
        "Location for scientific research and stargazing,",
        "Far from human-made noise.",
        "Antarctica is home to unique wildlife and",
        "Stunning landscapes, making it a place of",
        "Endless wonder and discovery.",
        "Exploring its frozen expanse is an adventure"
    ]),
    
    ColorValue(colorCode: "#B8860B", title: "Pando Forest", subtitle: "Ancient Clonal Colony", source: "Science", image: UIImage(named: "Image 2")!, description: [
        "Pando, a remarkable grove of quaking aspen trees",
        "In Utah, is a single organism connected by",
        "Underground roots. Estimated to be over 80,000",
        "Years old, it's one of the world's oldest and",
        "Heaviest living organisms, yet its individual",
        "Trees have a relatively short lifespan.",
        "This unique forest ecosystem provides vital",
        "Habitat for diverse wildlife and offers",
        "Insights into the interconnectedness of life",
        "In nature.",
        "Protecting Pando is essential for preserving"
    ]),
    
    ColorValue(colorCode: "E15F41", title: "Bermuda Triangle", subtitle: "Magnetic Anomaly", source: "National Ocean Service", image: UIImage(named: "Image 3")!, description: [
        "The Bermuda Triangle, often called the 'Devil's Triangle,' is an area in the western part of the North Atlantic Ocean.",
        "It gained notoriety due to numerous reports of ships and aircraft mysteriously disappearing while traversing this region.",
        "One theory suggests that magnetic anomalies in the area may affect compass readings, leading to navigation errors.",
        "While the Bermuda Triangle has captured the public's imagination, many incidents have logical explanations.",
        "Some cases involve adverse weather conditions, human error, or mechanical failures.",
        "The area's reputation for mystery and intrigue continues to fuel fascination and speculation.",
        "The Bermuda Triangle remains a popular topic in literature, movies, and documentaries.",
        "Despite its reputation, many ships and planes safely traverse the area regularly.",
        "The region's unique environmental conditions, including rapid weather changes, contribute to its challenges.",
        "Researchers and scientists continue to investigate the mysteries of the Bermuda Triangle."
    ]),
    
    ColorValue(colorCode: "#00A3F0", title: "Machu Picchu", subtitle: "Lost Inca City", source: "History.com", image: UIImage(named: "Image 4")!, description: [
        "Machu Picchu, the ancient Incan citadel perched",
        "High in the Andes, remained hidden from the",
        "World until its rediscovery in 1911. Its stunning",
        "Architecture, precise construction, and enigmatic",
        "Purpose continue to captivate archaeologists",
        "And visitors alike.",
        "This UNESCO World Heritage site offers a glimpse",
        "Into the advanced engineering and culture of the",
        "Inca civilization.",
        "Exploring Machu Picchu is a journey back in time."
    ]),
    
    ColorValue(colorCode: "#006400", title: "The Great Wall", subtitle: "Visible from Space", source: "NASA", image: UIImage(named: "Image 5")!, description: [
        "Contrary to the myth, the Great Wall of China",
        "Isn't visible from space with the naked eye.",
        "However, from low Earth orbit, it's discernible",
        "Under the right conditions. This marvel of human",
        "Engineering stretches over 13,000 miles and is a",
        "UNESCO World Heritage site.",
        "The Great Wall's history and significance",
        "Make it an enduring symbol of China's",
        "Rich cultural heritage.",
        "Exploring the wall is a journey through history."
    ]),
    
    ColorValue(colorCode: "0066A3", title: "Göbekli Tepe", subtitle: "Ancient Megaliths", source: "National Geographic", image: UIImage(named: "Image 6")!, description: [
        "Göbekli Tepe, located in modern-day Turkey, is the world's oldest known temple complex, dating back over 11,000 years.",
        "Its massive stone pillars, adorned with intricate carvings, challenge conventional ideas about the timeline of human civilization.",
        "The site was rediscovered in the 1960s and has since become a significant archaeological discovery.",
        "Göbekli Tepe predates the construction of the Egyptian pyramids and Stonehenge by thousands of years.",
        "It consists of circular enclosures with T-shaped pillars, some standing up to 16 feet tall and weighing several tons.",
        "The purpose of Göbekli Tepe remains a subject of study and debate among archaeologists.",
        "It likely served as a religious or ceremonial site, with the carvings depicting various animals and symbols.",
        "The site's builders displayed advanced knowledge of architecture and engineering for their time.",
        "Göbekli Tepe offers insights into the social and spiritual life of ancient hunter-gatherer societies.",
        "It is a UNESCO World Heritage site and continues to intrigue and inspire researchers from around the world."
    ])
]
