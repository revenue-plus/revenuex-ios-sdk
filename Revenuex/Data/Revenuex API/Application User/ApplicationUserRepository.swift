//
//  ApplicationUserRepository.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 13.04.2021.
//

import Foundation
import Combine

protocol ApplicationUserRepositoryProtocol : RevenuexWebServicesProtocol {
 
//    func setAttributions(attributions:[String:String]) -> AnyPublisher<EmptyResponse, APIError>
    
}

public struct ApplicationUserRepository : ApplicationUserRepositoryProtocol {
    
    
//    
//    func setAttributions(attributions: [String : String]) -> AnyPublisher<EmptyResponse, APIError> {
//        return execute(request: SetAttributionsRequest(attributions: attributions))
//    }
    
    var session: URLSession
    
    var baseURL: String
    
    var systemInfo: SystemInfoProtocol
    
    var sdkCredentials: SDKCredentialsProtocol
    
    

}
