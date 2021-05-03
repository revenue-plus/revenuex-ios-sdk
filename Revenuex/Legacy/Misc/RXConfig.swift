//
//  RXConfig.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit

class REVConfig {

    static let current = REVConfig()
    
    private init () {}
    
    let hostName:String = "sdk.revenueplus.net"
    let urlScheme:String = "https"
    
    var isSandbox:Bool = false
    
}
