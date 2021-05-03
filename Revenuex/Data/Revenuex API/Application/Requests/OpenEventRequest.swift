//
//  OpenEventRequest.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 11.04.2021.
//

import Foundation

struct OpenEventRequest  {
    
    var path: String = "/api/transactions/application-users/open-event"
    
    var method: HTTPMethod = .POST
    
    var headers: [String : String]?
    
    var bodyItems: [String : Any]?
    
}
