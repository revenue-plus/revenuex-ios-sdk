//
//  REVErrorResponse.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 7.04.2021.
//

import UIKit

class REVAPIError: Codable {

    
    private var code:Int
    private var status:Int
    private var message:String
    private var localizedMessage:String

    
    private enum CodingKeys: String, CodingKey {
        case status = "error.status"
        case code = "error.code"
        case localizedMessage = "error.localizedMessage"
        case message = "error.message"
    }
    
    var error:REVError {
        switch code {
        case 10003:
            return .UnknownError
        case 10001:
            return .UnknownError
        case 10007:
            return .UnknownError
        default:
            return .UnknownError
        }
    }
    
}
