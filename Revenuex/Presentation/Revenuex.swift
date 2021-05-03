//
//  Revenuex.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 17.03.2021.
//

import Foundation
import StoreKit

public class Revenuex {
    
    var store = Store()
    var paymentObserver:PaymentObserver?
    var applicationStateObserver:ApplicationStateObserver?
    
    var networkSessionManager:NetworkSessionManager?
    var networkService:NetworkService?
    var networkConfiguration:NetworkConfiguration?
    
    var requester:NetworkRequester?
    var requesterErrorLogger:RequesterErrorLogger?
    var requesterErrorResolver:RequesterErrorResolver?
    
    var userRepository:RevenueXUserRepository?
    var userStorage:RevenuexUserStorage?

    var purchasesRepository:PurchasesRepository?

    public static let shared: Revenuex = {
        return Revenuex()
    }()
     
    private init() {}
    
    public func configure(with APIKey:String, observerMode:Bool = true) {
        
        //Network
        self.networkConfiguration = DefaultNetworkConfiguration(baseURL: SystemInfo.baseURL,
                                                                headers: [
                                                                    "clientid":APIKey,
                                                                    "platform":SystemInfo.platform,
                                                                    "platform-version":SystemInfo.platformVersion,
                                                                    "sandbox":"\(SystemInfo.isSandbox)",
                                                                    "app-version":SystemInfo.appVersion,
                                                                    "region":SystemInfo.region,
                                                                    "device-name":SystemInfo.deviceName
                                                                ],
                                                                queryParameters: [:])
        self.networkSessionManager = DefaultNetworkSessionManager()
        self.networkService = DefaultNetworkService(config: self.networkConfiguration!, sessionManager: self.networkSessionManager!)
        
        self.requesterErrorLogger = DefaultRequesterErrorLogger()
        self.requesterErrorResolver = DefaultRequesterErrorResolver()
        self.requester = DefaultNetworkRequester (networkService: self.networkService!,
                                                errorResolver: self.requesterErrorResolver!,
                                                errorLogger: self.requesterErrorLogger!)
        
        //Data
        self.userStorage = UserDefaultsRevenueXUserStorage(userDefaults: UserDefaults.standard)
       
        self.userRepository = DefaultRevenueXUserRepository(requester: self.requester!,
                                                    cache: self.userStorage!)
        
        self.paymentObserver = DefaultPaymentObserver(paymentQueue: SKPaymentQueue.default(), delegate: self)
        self.purchasesRepository = DefaultPurchasesRepository(requester: requester!)
        
        //Observers
        self.applicationStateObserver = DefaultApplicationStateObserver(delegate: self)

        start()
    }
    
}

private extension Revenuex {
    
    func applicationDidStart(with revenuexUser:RevenueXUserDTO) {
        guard
            let userRepository = userRepository,
            let purchasesRepository = purchasesRepository
        else {return}
        
        store.revenuexUserId = revenuexUser.revenueXId
        
        LogOpenEventUseCase(userRepository: userRepository, userId: revenuexUser.revenueXId)
            .execute()
        
        GetOfferingsUseCase(purchases: purchasesRepository, userId: revenuexUser.revenueXId,
                            completion: { (_) in
                                self.paymentObserver?.start()
        })
            .execute()
        
        applicationStateObserver?.start()
    }
    
    func start() {
        guard let userRepository = userRepository else {return}
        
        GetApplicationUserUseCase
            .init(userRepository: userRepository) {[weak self] (result) in
                if case let .success(user) = result {
                    self?.applicationDidStart(with: user)
                }
            }
            .execute()

    }
    

}
