//
//  NetworkManager.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 8.04.2021.
//

import UIKit

typealias REVNetworkManagerCompletionBlock<ResponseModel:Codable> = ((Result<ResponseModel, REVError>))->()

protocol REVRequestable {

    associatedtype ResponseModel:Codable
    
    var path:String? {get }
    var httpMethod:REVHttpMethod {get}
    var networkManager: REVNetworkManager<ResponseModel> {get}
}

extension REVRequestable {
    
    
    func addHeader(name:String, value:String) {
        networkManager.defaultHttpHeaders[name] = value
    }
    
    func addQueryItem(name:String, value:String?) {
        networkManager.queryItems.append(.init(name: name, value: value))
    }
    
    func addBodyItem(name:String, value:Any) {
        networkManager.bodyItems[name] = value
    }
    
    func start(_ completion: REVNetworkManagerCompletionBlock<ResponseModel>? = nil) {
        networkManager.startRequest(path: path,
                                    httpMethod: httpMethod) { (result) in
            completion?(result)
        }
    }
    
}

enum REVHttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum REVHttpStatus {
    
    //An informational response indicates that the request was received and understood. It is issued on a provisional basis while request processing continues. It alerts the client to wait for a final response.
    case Information
    
    //Indicates the action requested by the client was received, understood, and accepted.
    case Succcess
    
    //Indicates the client must take additional action to complete the request.
    case Redirection
    
    //Intended for situations in which the error seems to have been caused by the client.
    case ClientError
    
    //Server is incapable of performing the request.
    case ServerError
    
    //The codes that are not specified by any standard
    case Unofficial(code: Int)
    
    static func getStatus(by response: URLResponse?) -> REVHttpStatus {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 600
        switch statusCode {
        case 100...199:
            return .Information
        case 200...299:
            return .Succcess
        case 300...399:
            return .Redirection
        case 400...499:
            return .ClientError
        case 500...599:
            return .ServerError
        default:
            return .Unofficial(code: statusCode)
        }
    }
}

class REVNetworkManager<ResponseModel:Codable> {
    
    static var new:REVNetworkManager<ResponseModel> {
        return REVNetworkManager<ResponseModel>()
    }
    
    var queryItems = [URLQueryItem]()
    var bodyItems = [String:Any]()
    var config:REVConfig
    
    init (config: REVConfig = REVDependencyContainer.resolve()) {
        self.config = config
    }
    
    lazy var defaultHttpHeaders:[String:String] = {
        return [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "platform-version" : REVSystemInfo.platformVersion,
            "platform": REVSystemInfo.platform,
            "sandbox":"\(REVSystemInfo.isSandbox)"
        ]
    }()

    func addHeader(name:String, value:String) {
        defaultHttpHeaders[name] = value
    }
    
    func addQueryItem(name:String, value:String?) {
        queryItems.append(.init(name: name, value: value))
    }
    
    func addBodyItem(name:String, value:Any) {
        bodyItems[name] = value
    }

    
    func generateRequest(url:URL, httpMethod:String) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        self.defaultHttpHeaders.forEach({request.setValue($0.value, forHTTPHeaderField: $0.key)})
               
        if let bodyData = try? JSONSerialization.data(withJSONObject: bodyItems, options: []) {
           request.httpBody = bodyData
        }

        return request
    }
    
    func handleResponse(urlResponse:URLResponse?, data:Data?, completion: @escaping REVNetworkManagerCompletionBlock<ResponseModel>){
        
        guard let data = data, data.isEmpty == false else {
            completion(.failure(.responseError(reason: .inputDataNilOrZeroLength)))
            return
        }
        let status = REVHttpStatus.getStatus(by: urlResponse)
        
        switch status {
        case .Information:
            break;
        case .Succcess,.Redirection:
            //TODO: Maybe some of redirection related status codes should be considered as fail.
            do {
                let response:ResponseModel = try ResponseModel.decode(from: data)
                completion(.success(response))
            } catch  {
                completion(.failure(.responseError(reason: .decodingFailed(error: error))))
            }
        case .ClientError:
            completion(.failure(.responseError(reason: .clientError(response: try?  REVErrorResponse.decode(from: data)))))
        case .ServerError:
            completion(.failure(.responseError(reason: .serverError(response: try?  REVErrorResponse.decode(from: data)))))
        case .Unofficial(let code):
            completion(.failure(.responseError(reason: .unofficialHttpStatusCode(code: code))))
        }
    }
    
    func startRequest(path:String?, httpMethod:REVHttpMethod, completion: @escaping REVNetworkManagerCompletionBlock<ResponseModel>) {
        
        var components = URLComponents()
        components.scheme = config.urlScheme
        components.host = config.hostName
        if let path = path {
            components.path = path
        }
        components.queryItems = queryItems
        
        guard let url = components.url else {
            completion(.failure(.parameterEncodingFailed(reason: .missingURL)))
            return
        }
        let session = URLSession.shared
        let request = generateRequest(url: url, httpMethod: httpMethod.rawValue)
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error: error)))
            } else {
                self?.handleResponse(urlResponse: response, data:data, completion: completion)
            }
        }
        task.resume()
    }
    
}
