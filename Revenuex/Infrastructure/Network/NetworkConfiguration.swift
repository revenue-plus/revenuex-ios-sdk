//
//  ServiceConfig.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 19.04.2021.
//

import Foundation

public protocol NetworkConfiguration {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct DefaultNetworkConfiguration: NetworkConfiguration {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
}
