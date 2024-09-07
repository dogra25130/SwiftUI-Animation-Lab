//
//  PodCastModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

struct PodCastInfoModel: Codable {
    let id: String
    let title: String
    let authors: String
    let url: String
    let episodeInfo: PodCastEpisodeInfoModel
    let episodes: [PodCastModel]
    let likeCount: Int
    let dislikeCount: Int
    let image: String
    
}
struct PodCastEpisodeInfoModel: Codable {
    let desc: String
    let episodeTitle: String
    let size: String
}
