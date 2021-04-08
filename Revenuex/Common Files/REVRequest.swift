//
//  RXRequest.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import CoreFoundation

enum REVHttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum REVHttpStatus {
    
    //An informational response indicates that the request was received and understood. It is issued on a provisional basis while request processing continues. It alerts the client to wait for a final response.
    case Information
    
    //This class of status codes indicates the action requested by the client was received, understood, and accepted.
    case Succcess
    
    //This class of status code indicates the client must take additional action to complete the request.
    case Redirection
    
    //This class of status code is intended for situations in which the error seems to have been caused by the client.
    case ClientError
    
    //Indicates cases in which the server is aware that it has encountered an error or is otherwise incapable of performing the request.
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

class REVRequest<T:Codable> {
    
    typealias REVRequestSuccessClosure = (T) -> ()
    typealias REVRequestFailClosure = (Error) -> ()
    
    private var queryItems = [URLQueryItem]()
    private var bodyItems = [String:Any]()
    
    var path:String {
        return "/"
    }
    var httpMethod:REVHttpMethod {
        return .GET
    }
    
    lazy private var defaultHttpHeaders:[String:String] = {
        return [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "platform-version" : REVSystemInfo.platformVersion,
            "platform": REVSystemInfo.platform,
            "sandbox":"\(REVConfig.current.isSandbox)"
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
    
}

private extension REVRequest {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = REVConfig.current.urlScheme
        components.host = REVConfig.current.hostName
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    func generateRequest(url:URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        self.defaultHttpHeaders.forEach({request.setValue($0.value, forHTTPHeaderField: $0.key)})
               
        if let bodyData = try? JSONSerialization.data(withJSONObject: bodyItems, options: []) {
           request.httpBody = bodyData
        }
    
        return request
    }
    
    func handleResponse(urlResponse:URLResponse?, data:Data?, _ onSuccess:REVRequestSuccessClosure? = nil, _ onFail:REVRequestFailClosure? = nil){
        
        guard let data = data, data.isEmpty == false else {
            onFail?(REVError.responseError(reason: .inputDataNilOrZeroLength))
            return
        }
        let status = REVHttpStatus.getStatus(by: urlResponse)
        
        switch status {
        case .Information:
            break;
        case .Succcess,.Redirection:
            //TODO: Maybe some of redirection related status codes should be considered as fail.
            do {
                onSuccess?(try T.decode(from: data))
            } catch  {
                onFail?(REVError.responseError(reason: .decodingFailed(error: error)))
            }
        case .ClientError:
            onFail?(REVError.responseError(reason: .clientError(response: try?  REVErrorResponse.decode(from: data))))
        case .ServerError:
            onFail?(REVError.responseError(reason: .serverError(response: try?  REVErrorResponse.decode(from: data))))
        case .Unofficial(let code):
            onFail?(REVError.responseError(reason: .unofficialHttpStatusCode(code: code)))
            break
        }
    }
    
    func startRequest(_ onSuccess:REVRequestSuccessClosure? = nil, _ onFail:REVRequestFailClosure? = nil) {
        guard let url = self.url else {
            onFail?(REVError.parameterEncodingFailed(reason: .missingURL))
            return
        }
        let session = URLSession.shared
        let request = generateRequest(url: url)
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                onFail?(error)
            } else {
                self?.handleResponse(urlResponse: response, data:data, onSuccess, onFail)
            }
        }
        task.resume()
    }
    
}
