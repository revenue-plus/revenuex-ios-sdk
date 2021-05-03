//
//  GenerateApplicationUserIdUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

protocol GenerateApplicationUserIdUseCaseProtocol:UseCase {
    var completion: (Result<String, Error>) -> Void {get}
}

struct GetApplicationUserIdUseCase : GenerateApplicationUserIdUseCaseProtocol {
    
    var completion: (Result<String, Error>) -> Void
    
    func execute() {
        let userId = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        completion(.success(userId))
    }
    
}
