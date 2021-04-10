//
//  RXSystemInfo.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit
        
class REVSystemInfo {

    static var platform:String {
        return "ios"
    }
    
    static var platformVersion:String {
        return ProcessInfo().operatingSystemVersionString
    }
    
    static var isSandbox:Bool {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return false
        }
        let receiptURLString = url.path;
        return receiptURLString.contains("sandboxReceipt")
    }
    
    
}
