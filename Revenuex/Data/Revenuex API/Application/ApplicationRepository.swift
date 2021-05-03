//
//  ApplicationRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 13.04.2021.
//

import Foundation
import Combine

protocol ApplicationRepositoryProtocol : RevenuexWebServicesProtocol {
//    func sendOpenEvent(applicationUserId:String) -> AnyPublisher<EmptyResponse, APIError>
}

struct ApplicationRepository : ApplicationRepositoryProtocol {

//    func sendOpenEvent(applicationUserId:String) -> AnyPublisher<EmptyResponse, APIError> {
//        return execute(request: OpenEventRequest())
//    }
    
    var session: URLSession
    
    var baseURL: String
    
    var systemInfo: SystemInfoProtocol
    
    var sdkCredentials: SDKCredentialsProtocol
}
