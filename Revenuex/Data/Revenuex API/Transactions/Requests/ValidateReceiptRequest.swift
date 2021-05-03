//
//  ValidateReceiptRequest.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 11.04.2021.
//

import Foundation

struct ValidateReceiptRequest {
    
    var config: NetworkConfigurationProtocol
    
    var systemInfo: SystemInfoProtocol
    
    var path: String = "/api/transactions/validate"
    
    var method: HTTPMethod = .POST
    
    var headers: [String : String] {
        return [:]
    }
    
    var bodyItems: [String : Any]?
    
//    init(receiptData: String, price: Double, productId: String, currency: String, isSubscription: Bool) {
//        
//        bodyItems = [:]
//        
//        let product: [String: Any] = [
//            "productId": productId,
//            "price": price,
//            "currency": currency
//        ]
//        
//        bodyItems?["products"] = [product]
//        bodyItems?["isSubscription"] = isSubscription
//        bodyItems?["receiptData"] = receiptData
//        
//    }
    
}
