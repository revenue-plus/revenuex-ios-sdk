//
//  SetAttributionsRequest.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 11.04.2021.
//

import Foundation

struct SetAttributionsRequest {
    
    var path: String = "/api/transactions/application-users/set-attributes"
    
    var method: HTTPMethod = .POST
    
    var headers: [String : String]?
    
    var bodyItems: [String : Any]?
    
    init(attributions:[String:String]) {
        bodyItems = [:]
        bodyItems?["attributes"] = attributions.compactMap({["key":$0.key, "value":$0.value]})
    }
}
