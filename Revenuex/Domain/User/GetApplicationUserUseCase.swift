//
//  GetApplicationUserUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 30.04.2021.
//

import Foundation

protocol GetApplicationUserUseCaseProtocol : UseCase {
    var userRepository: RevenueXUserRepository {get}
    var completion: (Result<RevenueXUserDTO, Error>) -> Void {get}
}

struct GetApplicationUserUseCase : GetApplicationUserUseCaseProtocol {
    var userRepository: RevenueXUserRepository
    var completion: (Result<RevenueXUserDTO, Error>) -> Void
    
    func execute() {
        userRepository.getApplicationUser { (result) in
            if case let .success(u) = result, let user = u {
                completion(.success(user))
            } else if case let .failure(error) = result {
                completion(.failure(error))
            }else {
                createApplicationUser()
            }
        }
    }
    
    private func createApplicationUser() {
        let initialUserId = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        userRepository.registerUser(userId: initialUserId) { (result) in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
