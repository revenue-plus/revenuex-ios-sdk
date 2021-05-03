//
//  SystemInfo.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 17.04.2021.
//

import Foundation


struct SystemInfo {
    static var baseURL:URL {
        return URL(string: "https://sdk-test.revenueplus.net")!
    }
    
    static var platform: String {
        return "14.5"
    }
    
    
    static var platformVersion: String {
        return "ios"
    }
    
    static var region: String {
        return "TR"
    }
    
    static var appVersion: String {
        return "1.0"
    }
    
    static var isSandbox: Bool {
        return true
    }
    
    static var deviceName: String {
        return "ads"
    }
    
    
    

}
