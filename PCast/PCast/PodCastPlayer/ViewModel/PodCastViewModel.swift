//
//  PodCastViewModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

import Foundation
enum LikeDisLikeStatus {
    case like
    case dislike
    case none
}

@MainActor
class PodCastViewModel: ObservableObject {
    
    let model: PodCastModel
    let usecase: PodCastUseCase
    @Published var likeDislikeStatus: LikeDisLikeStatus = .none
    @Published var data: PodCastInfoModel?
    
    init(model: PodCastModel, usecase: PodCastUseCase = PodCastService()) {
        self.model = model
        self.usecase = usecase
    }
    
    public func fetchData() async {
        let result = await usecase.getPodCastInfo(for: model)
        switch result {
        case .success(let res):
            data = res
        case .failure(let error):
            print(error)
        }
    }
    
    func updateLikeDislikeStatus(status: LikeDisLikeStatus) {
        likeDislikeStatus = status
    }
    
    func getLikeCount() -> String {
        let count = (data?.likeCount ?? 0) + (likeDislikeStatus == .like ? 1 : 0)
        return String(count)
    }
    
    func getDislikeCount() -> String {
        let count = (data?.dislikeCount ?? 0) + (likeDislikeStatus == .dislike ? 1 : 0)
        return String(count)
    }
}
