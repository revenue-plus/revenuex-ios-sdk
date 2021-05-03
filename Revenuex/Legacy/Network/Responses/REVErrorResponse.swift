//
//  REVErrorResponse.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 7.04.2021.
//

import UIKit




public class REVErrorResponse: Codable {
    
    private var code:Int
    private var status:Int
    private var message:String
    private var localizedMessageKey:String

    
    private enum CodingKeys: String, CodingKey {
        case status = "error.status"
        case code = "error.code"
        case localizedMessageKey = "error.localizedMessageKey"
        case message = "error.message"
    }

}


extension REVErrorResponse:LocalizedError {
    public var errorDescription: String? {
        return message
    }
    
}
