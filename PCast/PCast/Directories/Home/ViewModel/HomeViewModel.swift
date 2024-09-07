//
//  HomeViewModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var homeDataModel: HomeModel? { didSet { setupSection() } }
    @Published var currentTrendingPodcastModel: PodCastSectionModel?
    @Published var currentAuthor: AuthorSectionModel?
    
    var cancellables = Set<AnyCancellable>()
    let usecase: HomeUseCase
    
    init(usecase: HomeUseCase = HomeService()) {
        self.usecase = usecase
    }
    
    private func setupSection() {
        currentTrendingPodcastModel = homeDataModel?.trendingPodcastModel.podcastSectionModel.first
        currentAuthor = homeDataModel?.authorPodcastModel.authorSectionModel.first
    }
}

extension HomeViewModel {
    
    func fetchData() {
        Task {
            let homeData = await usecase.fetchData()
            switch homeData {
            case .success(let res):
                homeDataModel = res
                
            case .failure(let err):
                print(err)
//                 break
            }
        }
    }
    
    func updateCurrentTrendingPodcastModel(with model: PodCastSectionModel) {
        currentTrendingPodcastModel = model
    }
    
    func updateCurrentAuthor(with model: AuthorSectionModel) {
        currentAuthor = model
    }
}
