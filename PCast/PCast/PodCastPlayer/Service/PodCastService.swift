//
//  PodCastInfoService.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

import Foundation
protocol PodCastUseCase {
    func getPodCastInfo(for model: PodCastModel) async -> Result<PodCastInfoModel, Error>
}

class PodCastService {
    
}

extension PodCastService: PodCastUseCase {
    
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
}
