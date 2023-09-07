//
//  VideoManager.swift
//  VideoPlayerCollection
//
//  Created by Abhishek Dogra on 06/09/23.
//

import Foundation
enum Query: String, CaseIterable {
    case nature, animal, people, ocean, food
}

class VideoManager: ObservableObject {
    @Published var video: [Video] = [previwVideo]
    @Published var selectedQuery: Query = .nature {
        didSet {
            Task.init {
                await findVideos(topic: selectedQuery)
            }
        }
    }
    
    init() {
        Task.init {
            await findVideos(topic: selectedQuery)
        }
    }
    
    func findVideos(topic: Query) async {
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic.rawValue)&per_page=10&orientation=potrait") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("oQeWcHGsDBit45pIAusWsL6P6jywJepaDtD8clrbIEGiVKZPFbmVdEjY", forHTTPHeaderField: "Authorization")
            let (data, respose) = try await URLSession.shared.data(for: urlRequest)
            guard (respose as? HTTPURLResponse)?.statusCode == 200 else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(ResponseBody.self, from: data)
            DispatchQueue.main.async {
                self.video = []
                self.video = decodedData.videos
            }
        } catch {
            print("Error fetching data..")
        }
    }
}

struct ResponseBody: Decodable {
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}

struct Video: Identifiable, Decodable {
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]
    
    struct User: Identifiable, Decodable {
        var id: Int
        var name: String
        var url: String
    }
    
    struct VideoFile: Identifiable, Decodable {
        var id: Int
        var quality: String
        var fileType: String
        var link: String
    }
}

