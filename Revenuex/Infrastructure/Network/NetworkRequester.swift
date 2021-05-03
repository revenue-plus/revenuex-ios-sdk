//
//  DataTransfer.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

enum RequestServiceError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol NetworkRequester {
    
    var networkService: NetworkService {get}
    var errorResolver: RequesterErrorResolver {get}
    var errorLogger: RequesterErrorLogger {get}
    
    typealias CompletionHandler<T> = (Result<T, RequestServiceError>) -> Void
    
    func request<T: Decodable>(with endpoint: Endpoint<T>,
                               completion: @escaping CompletionHandler<T>)

    func request<T>(with endpoint: Endpoint<T>,
                    completion: @escaping CompletionHandler<Void>)
}

protocol RequesterErrorResolver {
    func resolve(error: NetworkError) -> Error
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

struct DefaultNetworkRequester: NetworkRequester {

    let networkService: NetworkService
    
    let errorResolver: RequesterErrorResolver
    
    let errorLogger: RequesterErrorLogger
    
    
    func request<T: Decodable>(with endpoint: Endpoint<T>,
                               completion: @escaping CompletionHandler<T>){

        self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, RequestServiceError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    func request<T>(with endpoint: Endpoint<T>, completion: @escaping CompletionHandler<Void>){
        self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(.success(())) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, RequestServiceError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> RequestServiceError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}


// MARK: - Error Resolver
struct DefaultRequesterErrorResolver: RequesterErrorResolver {
    init() { }
    func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
struct JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

struct RawDataResponseDecoder: ResponseDecoder {
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
