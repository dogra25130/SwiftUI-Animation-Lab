//
//  NetworkManager.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 19/07/24.
//

import Foundation

enum APIPath: String {
    case sendOTP = "v1/sendotp"
}

enum APIRequestMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

enum NetworkErrorMessage: String {
    case invalidResponse = "Invalid Response"
    case invalidURL = "Invalid base URL"
    case responseError = "Error Response From API"
}

struct NetworkError: Error {
    let message: NetworkErrorMessage
    var errorCode: Int? = nil
    var customMessage: String? = nil
}

class NetworkManager {
    private var baseURLString = "https://abc.com/"
    
    @discardableResult
    func makeAPIRequest(url: APIPath, method: APIRequestMethod, params: [String: Any] = [:]) async throws -> Data? {
        guard let baseURL = URL(string: baseURLString) else {
            throw NetworkError(message: .invalidURL)
        }
        
        let fullURL = baseURL.appendingPathComponent(url.rawValue)
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        
        // For GET requests, append parameters to the URL
        if method == .get, !params.isEmpty {
            var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = params.compactMap { key, value in
                if let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    return URLQueryItem(name: key, value: valueString)
                }
                return nil
            }
            if let urlWithParams = urlComponents?.url {
                request.url = urlWithParams
            }
        }
        
        // For POST requests, encode parameters as JSON
        if method == .post {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        let session = URLSession.shared
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError(message: .invalidResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                var networkError = NetworkError(message: .responseError)
                networkError.errorCode = httpResponse.statusCode
                throw networkError
            }
            
            return data
        } catch {
            var networkError = NetworkError(message: .responseError)
            networkError.customMessage = "Request failed: \(error.localizedDescription)"
            throw networkError
        }
    }
}
