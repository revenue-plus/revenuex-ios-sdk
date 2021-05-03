//
//  RXSystemInfo.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit

protocol SystemInfoProtocol {
    var platform:String {get}
    var platformVersion:String {get}
    var isSandbox:Bool {get}
}
        
struct SystemInfo : SystemInfoProtocol{

    var platform:String {
        return "ios"
    }
    
    var platformVersion:String {
        return ProcessInfo().operatingSystemVersionString
    }
    
    var isSandbox:Bool {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return false
        }
        let receiptURLString = url.path;
        return receiptURLString.contains("sandboxReceipt")
    }
}
