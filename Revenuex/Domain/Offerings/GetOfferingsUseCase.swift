//
//  GetOfferingsUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

protocol GetOfferingsUseCaseProtocol : UseCase {
    var purchases: PurchasesRepository {get}
    var completion: ((Result<[OfferingDTO], Error>) -> Void)? {get}
}

struct GetOfferingsUseCase : GetOfferingsUseCaseProtocol {
     
    var purchases: PurchasesRepository
    var userId: String
    var completion: ((Result<[OfferingDTO], Error>) -> Void)? = nil
    
    func execute() {
        purchases.getOfferings { (result) in
            switch result {
            case .success(let offerings):
                completion?(.success(offerings))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
