//
//  APIEnpoints.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

struct APIEndpoints {
    
    static func sendOpenEvent(userId:String) -> Endpoint<UserDTO> {
        return Endpoint(path:"/api/transactions/application-users/open-event",
                        method: .get,
                        headerParamaters: ["userId":userId])
    }
    
    static func sendPaymentInfo(receiptData: String, price: Double, productId: String, currency: String, isSubscription:Bool) -> Endpoint<Void> {
        
        let product: [String: Any] = [
            "productId": productId,
            "price": price,
            "currency": currency
        ]
        
        let body: [String:Any] = [
            "products":[product],
            "isSubscription": isSubscription,
            "receiptData" : receiptData
        ]
        
        return Endpoint(path:"/api/transactions/validate",
                        method: .post,
                        bodyParamaters: body)
    }

}
