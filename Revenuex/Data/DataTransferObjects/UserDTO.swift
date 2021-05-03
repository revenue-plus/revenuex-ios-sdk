//
//  ApplicationUserDTO.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

struct RevenueXUserDTO : Codable{
    var id: Int
    var applicationId: String
    var revenueXId: String
    var platformVersion: String?
    var attributes: [AttiributeDTO] = []
}
