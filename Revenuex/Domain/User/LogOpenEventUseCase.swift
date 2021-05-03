//
//  File.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 30.04.2021.
//

import Foundation

protocol LogOpenEventUseCaseProtocol : UseCase {
    var userId:String {get}
    var userRepository:ApplicationUserRepository {get}
}

struct LogOpenEventUseCase : LogOpenEventUseCaseProtocol {
    
    var userRepository: ApplicationUserRepository
    
    var userId: String

    func execute() {
        userRepository.sendOpenEvent(userId: userId, completion: nil)
    }
    
}
