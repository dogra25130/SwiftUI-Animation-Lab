//
//  BaseScreenViewModel.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 23/07/24.
//

import SwiftUI

struct CardDetail: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let imageURL: String
    let finalPrice: String
    let price: String
    var aspectRatio: CGFloat = 1
    let ratings: CGFloat
}

struct BaseDataModel: Equatable, Identifiable {
    static func == (lhs: BaseDataModel, rhs: BaseDataModel) -> Bool {lhs.id == rhs.id }
    
    let id: String = UUID().uuidString
    let tabTitle: String
    let cardsDetails: [CardDetail] = [
        CardDetail(
            title: "Global Solutions",
            imageURL: "1",
            finalPrice: "$759.00",
            price: "$730.00",
            aspectRatio: 1.5,
            ratings: 4.8
        ),
        CardDetail(
            title: "Tech Innovations",
            imageURL: "4",
            finalPrice: "$899.99",
            price: "$850.50",
            aspectRatio: 1.25,
            ratings: 4.7
        ),
        CardDetail(
            title: "Prime Enterprises",
            imageURL: "5",
            finalPrice: "$499.99",
            price: "$470.00",
            aspectRatio: 1,
            ratings: 4.5
        ),
        CardDetail(
            title: "Apex Industries",
            imageURL: "3",
            finalPrice: "$649.50",
            price: "$620.00",
            aspectRatio: 1,
            ratings: 4.6
        ),
        CardDetail(
            title: "Dynamic Networks",
            imageURL: "6",
            finalPrice: "$850.00",
            price: "$800.00",
            aspectRatio: 1,
            ratings: 4.9
        ),
        CardDetail(
            title: "Visionary Concepts",
            imageURL: "2",
            finalPrice: "$780.00",
            price: "$740.00",
            aspectRatio: 1.0,
            ratings: 4.4
        ),
        CardDetail(
            title: "Elite Services",
            imageURL: "5",
            finalPrice: "$600.00",
            price: "$560.00",
            aspectRatio: 1,
            ratings: 4.3
        ),
        CardDetail(
            title: "NextGen Solutions",
            imageURL: "1",
            finalPrice: "$890.00",
            price: "$850.00",
            aspectRatio: 1.5,
            ratings: 4.6
        ),
        CardDetail(
            title: "Fusion Tech",
            imageURL: "4",
            finalPrice: "$720.00",
            price: "$690.00",
            aspectRatio: 1.25,
            ratings: 4.7
        ),
        CardDetail(
            title: "Strategic Partners",
            imageURL: "3",
            finalPrice: "$950.00",
            price: "$900.00",
            aspectRatio: 1,
            ratings: 4.9
        ),
        CardDetail(
            title: "Pioneer Systems",
            imageURL: "2",
            finalPrice: "$920.00",
            price: "$880.00",
            aspectRatio: 1.0,
            ratings: 4.8
        ),
        CardDetail(
            title: "Quantum Tech",
            imageURL: "6",
            finalPrice: "$980.00",
            price: "$950.00",
            aspectRatio: 0.75,
            ratings: 4.5
        )
    ]

    var splitArray: [[CardDetail]] {
        var result: [[CardDetail]] = []
        
        var list1: [CardDetail] = []
        var list2: [CardDetail] = []
        cardsDetails.forEach { details in
            let index = cardsDetails.firstIndex {$0.id == details.id }
            
            if let index = index {
                if index % 2 == 0  {
                    list1.append(details)
                } else {
                    list2.append(details)
                }
            }
        }
        result.append(list1)
        result.append(list2)
        return result
        
    }
}

class BaseScreenViewModel: ObservableObject {
    @Published var baseModel: [BaseDataModel] = []
    
    init() {
        fetchData(for: .accessories)
    }
    func fetchData(for tab: MenuOptions) {
        switch tab {
        case .clothes:
            baseModel = [BaseDataModel(tabTitle: "Men"), BaseDataModel(tabTitle: "Women"),
                         BaseDataModel(tabTitle: "Kids"), BaseDataModel(tabTitle: "Plus Size"),
                         BaseDataModel(tabTitle: "Teens")]
        case .jewellery:
            baseModel = [BaseDataModel(tabTitle: "Rings"), BaseDataModel(tabTitle: "Bracelets"),
                         BaseDataModel(tabTitle: "Necklace"), BaseDataModel(tabTitle: "Earrings")]
        case .accessories:
            baseModel = [BaseDataModel(tabTitle: "Gadgets"), BaseDataModel(tabTitle: "Handbags"),
                         BaseDataModel(tabTitle: "Sunglasses"), BaseDataModel(tabTitle: "Mobile"),
                         BaseDataModel(tabTitle: "Luggages")]
        case .premium:
            baseModel = [BaseDataModel(tabTitle: "Dolec & Gabta"), BaseDataModel(tabTitle: "Edel"),
                         BaseDataModel(tabTitle: "Jacod Dohem"), BaseDataModel(tabTitle: "Frula"),
                         BaseDataModel(tabTitle: "Lacosde")]
        default:
            break
        }
    }
}
#Preview {
    HomeScreen()
}
