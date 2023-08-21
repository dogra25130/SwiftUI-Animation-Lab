//
//  PageModel.swift
//  Pinch
//
//  Created by Abhishek Dogra on 02/06/23.
//

import Foundation
struct Page: Identifiable {
    let id: Int
    let imageName: String
}
extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
