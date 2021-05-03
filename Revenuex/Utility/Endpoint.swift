//
//  EndPoint.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 10.04.2021.
//

import Foundation



protocol RevenuexEndpoint {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}


extension RevenuexEndpoint {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.parameterEncodingFailed(reason: .missingURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}



