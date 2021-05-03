//
//  PaymentObserver.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 27.04.2021.
//

import Foundation
import StoreKit

protocol PaymentObserver {
    var paymentQueue:SKPaymentQueue {get}
    
    func handlePurchasedTransaction(transaction: SKPaymentTransaction)
    
    func start()
}

protocol PaymentObserverDelegate {
    func paymentObserverDidHandlePurchasedTransaction(transaction: SKPaymentTransaction)
}

class DefaultPaymentObserver : NSObject, PaymentObserver {

    var paymentQueue: SKPaymentQueue
    var delegate:PaymentObserverDelegate
    
    init(paymentQueue: SKPaymentQueue, delegate:PaymentObserverDelegate) {
        self.paymentQueue = paymentQueue
        self.delegate = delegate
        super.init()
    }
    
    func handlePurchasedTransaction(transaction: SKPaymentTransaction) {
        self.delegate.paymentObserverDidHandlePurchasedTransaction(transaction: transaction)

    }
    
    func start() {
        self.paymentQueue.add(self)
    }
    
}

extension DefaultPaymentObserver : SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .restored,
                 .purchased:
                handlePurchasedTransaction(transaction: transaction)
            case .deferred,
                 .purchasing,
                 .failed:
                //TODO: Improve handling transaction states for further implementaions of payment cycle. (Making payments, fetching products with SDK etc..)
                break
            @unknown default:
                break
            }
        }
    }
}
