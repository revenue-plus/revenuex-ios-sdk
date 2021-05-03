//
//  RXRequest.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit


internal enum REVHttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class REVRequest<RXResponse> {
    
    typealias RXRequestSuccessClosure = (RXResponse) -> ()
    
    private var queryItems = [URLQueryItem]()
    private var bodyItems = [String:Any]()
    
    var path:String {
        return "/"
    }
    var httpMethod:REVHttpMethod {
        return .GET
    }
    var dateDecodingStrategy:JSONDecoder.DateDecodingStrategy {
        return .secondsSince1970
    }
    
    lazy private var defaultHttpHeaders:[String:String] = {
        return [
            "Content-Type":"application/json",
            "Accept":"application/json",
            "platform-version" : RXSystemInfo.platformVersion,
            "platform": RXSystemInfo.platform,
            "sandbox":"\(RXConfig.current.isSandbox)"
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
        components.scheme = RXConfig.current.urlScheme
        components.host = RXConfig.current.hostName
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
}
