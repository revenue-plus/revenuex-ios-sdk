//
//  SetAttiributionUseCase.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

protocol SetAttiributionLocallyUseCaseProtocol : UseCase {
    var userId:String {get}
    var name:String {get}
    var value:Any {get}
    var userRepository:RevenueXUserRepository {get}
}



struct SetAttiributionLocallyUseCase : SetAttiributionLocallyUseCaseProtocol {

    var userId: String
    
    var name:String
    
    var value:Any
    
    var userRepository: RevenueXUserRepository
    
    func execute() {
        //TODO:
    }
}
