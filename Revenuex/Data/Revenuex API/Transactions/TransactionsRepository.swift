//
//  TransactionsRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 13.04.2021.
//

import Foundation
import Combine

protocol TransactionsRepositoryProtocol : RevenuexWebServicesProtocol {
//    func validateReceipt(receiptData: String, price: Double, productId: String, currency: String, isSubscription: Bool) -> AnyPublisher<EmptyResponse, APIError>
}

struct TransactionsRepository : TransactionsRepositoryProtocol {
    
    
//    
//    func validateReceipt(receiptData: String, price: Double, productId: String, currency: String, isSubscription: Bool) -> AnyPublisher<EmptyResponse, APIError> {
//        return execute(request: ValidateReceiptRequest(receiptData: receiptData,
//                                                       price: price,
//                                                       productId: productId,
//                                                       currency: currency,
//                                                       isSubscription: isSubscription))
//    }
//    
    var session: URLSession
    
    var baseURL: String
    
    var systemInfo: SystemInfoProtocol
    
    var sdkCredentials: SDKCredentialsProtocol
    
}
