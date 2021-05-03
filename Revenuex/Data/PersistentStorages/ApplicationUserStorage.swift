//
//  UserStorageProtocol.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation
import Combine

protocol ApplicationUserStorage {
    func getUser(completion: @escaping (Result<UserDTO?, Error>) -> Void)
    func saveUser(user: UserDTO, completion: @escaping (Result<Void, Error>) -> Void)
}

struct UserDefaultsApplicationUserStorage : ApplicationUserStorage {
    
    var userDefaults: UserDefaults
    
    func getUser(completion: @escaping (Result<UserDTO?, Error>) -> Void){
        guard let data = userDefaults.data(forKey: "user") else {
            completion(.success(nil))
            return
        }
        do {
            let user = try JSONDecoder().decode(UserDTO.self, from: data)
            completion(.success(user))
        }catch {
            completion(.failure(error))
        }
    }
    
    func saveUser(user: UserDTO, completion: @escaping (Result<Void, Error>) -> Void){
        do {
            let userData = try JSONEncoder().encode(user)
            userDefaults.setValue(userData, forKey: user.userId)
            completion(.success(()))
        }catch {
            completion(.failure(error))
        }

    }
    
}
