//
//  VideoModel.swift
//  Africa
//
//  Created by Abhishek Dogra on 04/06/23.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    var thumbnail: String {
        "video-\(id)"
    }
}
