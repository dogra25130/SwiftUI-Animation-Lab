//
//  APIError.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation

enum APIErrorCode: String {
    case invalidURL
    case invalidResponse
    case serverError
}

public struct APIError: Error {
    
    public let errorCode: String
    public let responseCode: Int?
    public let title: String?
    public let message: String?
    
    /// - Parameters:
    ///   - errorCode: Error code
    ///   - responseCode: Response Code
    ///   - title: Title of the error string
    ///   - message: Message of the error
    public init(errorCode: String, responseCode: Int? = nil, title: String? = nil, message: String? = nil) {
        self.errorCode = errorCode
        self.responseCode = responseCode
        self.title = title
        self.message = message
    }
}

