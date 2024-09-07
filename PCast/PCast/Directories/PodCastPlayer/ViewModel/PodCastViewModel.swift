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

class PodCastViewModel: NSObject, ObservableObject {
    
    let model: PodCastModel
    let usecase: PodCastUseCase
    @Published var likeDislikeStatus: LikeDisLikeStatus = .none
    @Published var data: PodCastInfoModel?
    @Published var currentDownloadingProgress: CGFloat = .zero
    private var downloadedQueue: [PodCastModel] = []
    private var downloadQueue: [PodCastModel] = []
    private var currentDownloadingModel: PodCastModel?
    

    init(model: PodCastModel, usecase: PodCastUseCase = PodCastService()) {
        self.model = model
        self.usecase = usecase
        super.init()
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

extension PodCastViewModel {
    func startDownload(_ model: PodCastModel) {
        currentDownloadingProgress = .zero
        downloadQueue.append(model)
        if currentDownloadingModel == nil {
            currentDownloadingModel = model
            handleDownloadStatus(model)
        }
    }
    
    func isDownloading(_ model: PodCastModel) -> Bool { model == currentDownloadingModel }
    
    func isDownloaded(_ model: PodCastModel) -> Bool { downloadedQueue.contains(model) }
    
    func inDownloadingQueue(_ model: PodCastModel) -> Bool { downloadQueue.contains(model) }
    
    private func handleDownloadStatus(_ model: PodCastModel)  {
        usecase.startDownload(for: model) { [weak self] progress in
            guard let self else { return }
            Task {
                await MainActor.run {
                    self.currentDownloadingProgress = progress
                }
            }
        } downloadCompletion: { [weak self] model in
            guard let self else { return }
            Task {
                await MainActor.run {
                    self.downloadedQueue.append(model)
                    self.downloadQueue = self.downloadQueue.filter { $0 != model }
                    self.currentDownloadingModel = nil
                    if let model = self.downloadQueue.first { self.handleDownloadStatus(model) }
                }
            }
        }
    }
}
