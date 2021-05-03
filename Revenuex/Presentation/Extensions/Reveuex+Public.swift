//
//  Reveuex+Public.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

extension Revenuex {
    
    public func setAttiribution(name:String, value:String) {
        
        guard
            let userRepository = self.userRepository,
            let userId = self.store.revenuexUserId
        else {return}
        
        SetAttiributionLocallyUseCase
            .init(userId: userId, name: name, value: value, userRepository: userRepository)
            .execute()
    }

}
