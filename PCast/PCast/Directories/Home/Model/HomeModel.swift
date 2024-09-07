//
//  HomeModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Foundation

struct PodCastModel: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let date: String
    let duration: String
    let authorName: String
    let image: String
    let size: String
    let url: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TrendingPodCastModel: Codable {
    let headline: String
    let podcastSectionModel: [PodCastSectionModel]
}

struct PodCastSectionModel: Codable, Identifiable {
    let id: String
    let sectionName: String
    let podcastModel: [PodCastModel]
}

struct AuthorPodCastModel: Codable {
    let headline: String
    let authorSectionModel: [AuthorSectionModel]
}

struct AuthorSectionModel: Codable, Identifiable {
    let id: String
    let sectionName: String
    let authors: [AuthorDetail]
}

struct AuthorDetail: Codable, Identifiable {
    let id: String
    let name: String
    let numberOfPodcasts: Int
    let image: String
}

struct HomeModel: Codable, Equatable {
    let id: String
    let suggestionPodCastModel: [PodCastModel]
    let trendingPodcastModel: TrendingPodCastModel
    let authorPodcastModel: AuthorPodCastModel
    static func == (lhs: HomeModel, rhs: HomeModel) -> Bool {
        lhs.id == rhs.id
    }
}
