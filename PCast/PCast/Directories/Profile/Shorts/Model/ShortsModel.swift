//
//  ReelsModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/09/24.
//

import Foundation
struct ReelsModel: Identifiable {
    let id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded = false
}

let reelsModelData = [
    ReelsModel(url: "video_1", title: "video 1"),
    ReelsModel(url: "video_2", title: "video 2"),
    ReelsModel(url: "video_3", title: "video 3"),
    ReelsModel(url: "video_4", title: "video 4"),
    ReelsModel(url: "video_5", title: "video 5"),
    ReelsModel(url: "video_6", title: "video 6")
]
