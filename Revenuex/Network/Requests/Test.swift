//
//  Test.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 8.04.2021.
//

import UIKit

class TestResponse:Codable{
    var testVal:String?
}

class Test: REVRequestable {
    
    typealias ResponseModel = TestResponse
    
    var networkManager: REVNetworkManager<TestResponse> = REVNetworkManager.new
    
    var path: String? = "test"
    
    var httpMethod: REVHttpMethod = .GET
    
    
    init(userName:String) {
        addQueryItem(name: "userName", value: userName)
    }
    
}
