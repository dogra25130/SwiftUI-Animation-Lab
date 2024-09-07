//
//  SearchService.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import Foundation
protocol SearchUseCase: AnyObject {
    func search(for value: String) async -> Result<[PodCastModel], Error>
}

class SearchService {
    
}

extension SearchService: SearchUseCase {
    func search(for value: String) async -> Result<[PodCastModel], Error> {
        guard !value.isEmpty else { return .success([]) }
        try? await Task.sleep(nanoseconds: 500_000_000)
        guard let filePath = Bundle.main.path(forResource: "searchData", ofType: "json") else {
            return .failure(NSError(domain: "File not found", code: 404, userInfo: nil))
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            let decoder = JSONDecoder()
            let homeModel = try decoder.decode([PodCastModel].self, from: data)
            
            return .success(homeModel)
        } catch {
            return .failure(error)
        }
    }
}
