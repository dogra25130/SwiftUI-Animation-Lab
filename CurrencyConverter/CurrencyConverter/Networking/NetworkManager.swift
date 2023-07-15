//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation

class NetworkManager: HomeUserCase {
    
    func getLatestRates(completion: @escaping (Result<ExchangeRateModel, APIError>) -> Void) {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=7470e718fb0846acb02173b9c200daa7") else {
            completion(.failure(APIError(errorCode: APIErrorCode.invalidURL.rawValue)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError(errorCode: APIErrorCode.serverError.rawValue)))
                return
            }
            
            if let data = data {
                let response = ExchangeRateResponse(with: data)
                if let data = response {
                    completion(.success(data.getModel()))
                }
            } else {
                completion(.failure(APIError(errorCode: APIErrorCode.invalidResponse.rawValue)))
            }
        }
        
        task.resume()
    }
}
