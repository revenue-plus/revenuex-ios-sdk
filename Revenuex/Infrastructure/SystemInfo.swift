//
//  SystemInfo.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 17.04.2021.
//

import Foundation


struct SystemInfo {
    static var baseURL:URL {
        return URL(string: "https://sdk.revenueplus.net")!
    }
    
    static var platform: String {
        return ""
    }
    
    
    static var platformVersion: String {
        return ""
    }
    
    static var isSandbox: Bool {
        return true
    }
    

}
