//
//  HomeService.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//
import Foundation
protocol HomeUseCase: AnyObject {
    func fetchData() async -> Result<HomeModel, Error>
}

class HomeService {
    
}

extension HomeService: HomeUseCase {
    func fetchData() async -> Result<HomeModel, Error> {
        try? await Task.sleep(nanoseconds: 500_000_000)
        guard let filePath = Bundle.main.path(forResource: "homeData", ofType: "json") else {
            return .failure(NSError(domain: "File not found", code: 404, userInfo: nil))
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            let decoder = JSONDecoder()
            let homeModel = try decoder.decode(HomeModel.self, from: data)
            
            return .success(homeModel)
        } catch {
            return .failure(error)
        }
    }
}
