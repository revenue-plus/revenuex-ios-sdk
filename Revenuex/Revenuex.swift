//
//  Revenuex.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 17.03.2021.
//

import Foundation

public class Revenuex {
    
    private static var revenuex:Revenuex!
    
    @Dependency private var configuration:REVConfig
    @Dependency private var applicationUser:REVApplicationUser
    @Dependency private var cache:REVCache
        

    init(configuration:REVConfig,
         applicationUser: REVApplicationUser,
         cache:REVCache ) {
        
        self.configuration = configuration
        self.applicationUser = applicationUser
        self.cache = cache
    }
    
    
    
    static func configure(configuration:REVConfig = REVDependencyContainer.resolve(),
                          applicationUser: REVApplicationUser = REVDependencyContainer.resolve(),
                          cache:REVCache = REVDependencyContainer.resolve()) {
        revenuex = .init(configuration: configuration, applicationUser: applicationUser, cache: cache)
    }
    
    static func setApplicationUserId(id:String) {
        revenuex.applicationUser.id = id
    }
    
    static func setAttribution(key:String, value:String) {
        revenuex.applicationUser.setAttribution(key: key, value: value)
    }
    

    
}
