//
//  RequestServiceErrorLogger.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 29.04.2021.
//

import Foundation

protocol RequesterErrorLogger {
    func log(error: Error)
}

struct DefaultRequestServiceErrorLogger: RequesterErrorLogger {
    init() { }
    
    func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}
