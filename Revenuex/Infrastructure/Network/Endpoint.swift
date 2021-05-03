//
//  Endpoint.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum DataEncoding {
    case json
    case string
}

struct Endpoint<R> {

    typealias Response = R
    
    var path: String
    var method: HTTPMethodType
    var headerParamaters: [String: String] = [:]
    var queryParameters: [String: Any] = [:]
    var bodyParamaters: [String: Any] = [:]
    var responseDecoder: ResponseDecoder = JSONResponseDecoder()
    var bodyEncoding: DataEncoding = .json

}

enum RequestGenerationError: Error {
    case components
}

extension Endpoint {
    
    func url(with config: NetworkConfiguration) throws -> URL {

        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()

        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    func urlRequest(with config: NetworkConfiguration) throws -> URLRequest {
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }

        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: DataEncoding) -> Data? {
        switch bodyEncoding {
        case .json:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .string:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
    }
}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
