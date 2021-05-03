//
//  TransactionsRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 27.04.2021.
//

import Foundation

protocol PurchasesRepository {
    
    var requester: NetworkRequester {get}
    
    func sendPaymentInfo(receiptData: String,
                         price: Double,
                         productId: String,
                         currency: String,
                         isSubscription: Bool,
                         completion: EmptyResult?)
    
    func getOfferings(completion: @escaping (Result<[OfferingDTO],Error>) -> Void)
    func cacheOfferings(offerings:[OfferingDTO])
}


struct DefaultPurchasesRepository : PurchasesRepository  {
    
    var requester: NetworkRequester
    
    func cacheOfferings(offerings: [OfferingDTO]) {
        //TODO:
    }
    
    func getOfferings(completion: @escaping (Result<[OfferingDTO], Error>) -> Void) {
        //TODO:
    }
    
    func sendPaymentInfo(receiptData: String,
                         price: Double,
                         productId: String,
                         currency: String,
                         isSubscription: Bool,
                         completion: EmptyResult?) {
        requester.request(with: APIEndpoints.sendPaymentInfo(receiptData: receiptData,
                                                             price: price,
                                                             productId: productId,
                                                             currency: currency,
                                                             isSubscription: isSubscription)) { (result) in
            switch result {
            case .success():
                completion?(.success(()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
}
