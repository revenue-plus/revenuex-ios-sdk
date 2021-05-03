//
//  UserRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation
import Combine

protocol ApplicationUserRepository {
    
    var requester: NetworkRequester {get}
    var cache:ApplicationUserStorage {get}
    
    func sendOpenEvent(userId:String, completion: EmptyResult?)
    func getApplicationUser(completion: @escaping (Result<UserDTO?, Error>) -> Void)
    func registerUser(userId:String, completion: @escaping (Result<UserDTO, Error>) -> Void)
    func syncAttiributions(userId:String, attiributions:[String:Any], completion: EmptyResult?)

}

struct DefaultApplicationUserRepository : ApplicationUserRepository {
    
    var requester: NetworkRequester
    var cache:ApplicationUserStorage
    
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

    
    func getApplicationUser(completion: @escaping (Result<UserDTO?, Error>) -> Void) {
        cache.getUser(completion: {completion($0)})
    }
    
    func registerUser(userId:String, completion: @escaping (Result<UserDTO, Error>) -> Void) {
        //TODO:
    }

    func syncAttiributions(userId:String, attiributions:[String:Any], completion: EmptyResult?) {
        //TODO:
    }
    
}
