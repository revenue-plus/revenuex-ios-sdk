//
//  UserRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation
import Combine

protocol RevenueXUserRepository {
    
    var requester: NetworkRequester {get}
    var cache:RevenuexUserStorage {get}
    
    func sendOpenEvent(userId:String, completion: EmptyResult?)
    func getApplicationUser(completion: @escaping (Result<RevenueXUserDTO?, Error>) -> Void)
    func registerUser(userId:String, completion: @escaping (Result<RevenueXUserDTO, Error>) -> Void)
    func syncAttiributions(userId:String, attiributions:[String:Any], completion: EmptyResult?)

}

struct DefaultRevenueXUserRepository : RevenueXUserRepository {
    
    var requester: NetworkRequester
    var cache:RevenuexUserStorage
    
    func sendOpenEvent(userId: String, completion: EmptyResult?) {
        requester.request(with: APIEndpoints.sendOpenEvent(userId: userId)) { (result) in
            switch result {
            case .success(let user):
                cache.saveUser(user: user) {completion?($0)}
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    
    func getApplicationUser(completion: @escaping (Result<RevenueXUserDTO?, Error>) -> Void) {
        cache.getUser(completion: {completion($0)})
    }
    
    func registerUser(userId:String, completion: @escaping (Result<RevenueXUserDTO, Error>) -> Void) {
        requester.request(with: APIEndpoints.sendOpenEvent(userId: userId)) { (result) in
            switch result {
            case .success(let user):
                cache.saveUser(user: user) { (result) in
                    switch result {
                    case .success():
                        completion(.success(user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func syncAttiributions(userId:String, attiributions:[String:Any], completion: EmptyResult?) {
        //TODO:
    }
    
}
