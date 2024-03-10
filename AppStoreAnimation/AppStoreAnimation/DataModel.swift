//
//  DataModel.swift
//  AppStoreAnimation
//
//  Created by Abhishek Dogra on 10/03/24.
//

import Foundation
struct DataModel: Identifiable {
    var id = UUID()
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artWork: String
    var desc: String
}

var dataItems: [DataModel] = [
    DataModel(appName: "Thynk Cafe", appDescription: "Thynk Cafe: Flavorful innovation, inviting conversations.", appLogo: "logo_1", bannerTitle: "Pizza Pleasure Unleashed.", platformTitle: "Starting from ₹299", artWork: "post_1", desc: """
Pizza, a universally loved culinary masterpiece, transcends borders with its delectable fusion of flavors. Originating from Italy, this iconic dish has evolved into a global sensation. A harmonious marriage of crisp crust, savory tomato sauce, melted cheese, and a myriad of toppings, pizza caters to diverse palates. Whether savoring a classic Margherita, indulging in pepperoni perfection, or embracing creative combinations, each slice tells a unique story. From humble pizzerias to gourmet parlors, this beloved dish brings people together, creating moments of shared joy. With its endless adaptability and irresistible appeal, pizza remains an eternal favorite, symbolizing the art of culinary delight.
"""),
    DataModel(appName: "The Wok", appDescription: "The Wok: A culinary journey where sizzling woks transform fresh ingredients into savory masterpieces.", appLogo: "logo_2", bannerTitle: "Savor Biryani Delight.", platformTitle: "Starting from ₹499", artWork: "post_2", desc: """
Biryani, a culinary delight hailing from the Indian subcontinent, is a symphony of aromatic spices and perfectly cooked rice. Originating centuries ago, this fragrant dish has become a staple in diverse cultures. The heart of biryani lies in the meticulous layering of basmati rice, marinated meat (often chicken, mutton, or beef), and a blend of spices, creating a rich tapestry of flavors. Saffron, mint, and fried onions contribute to its distinctive taste. Whether enjoyed in bustling street stalls or lavish feasts, biryani is more than a dish—it's a celebration of tradition, skill, and the culinary art of blending spices to perfection.
""")
]
