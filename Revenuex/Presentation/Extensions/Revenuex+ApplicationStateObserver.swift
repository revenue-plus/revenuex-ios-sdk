//
//  Revenuex+ApplicationStateObserver.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation

extension Revenuex : ApplicationStateObserverDelegate {

    func applicationWillEnterForeground() {
        guard
            let userId = store.revenuexUserId,
            let userRepository = userRepository
        else {return}
        
        SyncAttiributionsUseCase(userId: userId, userRepository: userRepository)
            .execute()
    }

    
}
