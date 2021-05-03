//
//  REVCodableExtension.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 7.04.2021.
//

import UIKit

extension Decodable {
    
    static func decode<T>(from data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try decoder.decode(T.self , from: data)
        return response
    }
    
}
