//
//  SyncAttiributionsUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

protocol SyncAttiributionsUseCaseProtocol : UseCase {
    var userRepository:RevenueXUserRepository {get}
    var userId:String {get}
    
}

struct SyncAttiributionsUseCase : SyncAttiributionsUseCaseProtocol {
    
    var userId: String
    
    var userRepository: RevenueXUserRepository

    func execute() {
        //TODO:
    }
}
