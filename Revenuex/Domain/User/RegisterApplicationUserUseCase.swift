//
//  RegisterApplicationUserUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 1.05.2021.
//

import Foundation

protocol RegisterApplicationUserUseCaseProtocol : UseCase {
    var userRepository: UserRepository {get}
    var completion: (Result<UserDTO, Error>) -> Void {get}
}

struct CreateApplicationUserUseCase : RegisterApplicationUserUseCaseProtocol {
    
    var userRepository: UserRepository
    var completion: (Result<UserDTO, Error>) -> Void
    
    func execute() {
        let userId = generateInitialUserId()
        userRepository.registerUser(userId: userId, completion: completion)
    }
    
    private func generateInitialUserId() -> String {
        return UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
    }
    
}
