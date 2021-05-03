//
//  UserStorageProtocol.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

protocol RevenuexUserStorage {
    func getUser(completion: @escaping (Result<RevenueXUserDTO?, Error>) -> Void)
    func saveUser(user: RevenueXUserDTO, completion: @escaping (Result<Void, Error>) -> Void)
}

struct UserDefaultsRevenueXUserStorage : RevenuexUserStorage {
    
    var userDefaults: UserDefaults
    
    func getUser(completion: @escaping (Result<RevenueXUserDTO?, Error>) -> Void){
        guard let data = userDefaults.data(forKey: "user") else {
            completion(.success(nil))
            return
        }
        do {
            let user = try JSONDecoder().decode(RevenueXUserDTO.self, from: data)
            completion(.success(user))
        }catch {
            completion(.failure(error))
        }
    }
    
    func saveUser(user: RevenueXUserDTO, completion: @escaping (Result<Void, Error>) -> Void){
        do {
            let userData = try JSONEncoder().encode(user)
            userDefaults.setValue(userData, forKey: "user")
            completion(.success(()))
        }catch {
            completion(.failure(error))
        }

    }
    
}
