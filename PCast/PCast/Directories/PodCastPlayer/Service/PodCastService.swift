//
//  PodCastInfoService.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

import Foundation
protocol PodCastUseCase {
    func getPodCastInfo(for model: PodCastModel) async -> Result<PodCastInfoModel, Error>
    func startDownload(for model: PodCastModel,
                       progressCompletion: @escaping (CGFloat) -> Void,
                       downloadCompletion: @escaping (PodCastModel) -> Void)
}

@objc class PodCastService: NSObject {
    private var session: URLSession?
    var downloadCompletion: ((PodCastModel) -> Void)?
    var progressCompletion: ((CGFloat) -> Void)?
    var currentModel: PodCastModel?
    override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate: self,
                             delegateQueue: nil)
    }
}

extension PodCastService: PodCastUseCase, URLSessionDownloadDelegate {
    
    func getPodCastInfo(for model: PodCastModel) async -> Result<PodCastInfoModel, Error> {
        try? await Task.sleep(nanoseconds: 500_000_000)
        guard let filePath = Bundle.main.path(forResource: "podcastData", ofType: "json") else {
            return .failure(NSError(domain: "File not found", code: 404, userInfo: nil))
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            let decoder = JSONDecoder()
            let homeModel = try decoder.decode(PodCastInfoModel.self, from: data)
            
            return .success(homeModel)
        } catch {
            return .failure(error)
        }
    }
    
    func startDownload(for model: PodCastModel,
                       progressCompletion: @escaping (CGFloat) -> Void,
                       downloadCompletion: @escaping (PodCastModel) -> Void) {
        guard let url = URL(string: model.url) else { return }
        let downloadTask = session?.downloadTask(with: URLRequest(url: url))
        downloadTask?.resume()
        currentModel = model
        self.progressCompletion = progressCompletion
        self.downloadCompletion = downloadCompletion
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let currentModel { downloadCompletion?(currentModel) }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let fractionReceived = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        progressCompletion?(fractionReceived)
    }
}
