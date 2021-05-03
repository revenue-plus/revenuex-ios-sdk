//
//  ApplicationStateHandler.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 2.05.2021.
//

import Foundation
import UIKit

protocol ApplicationStateObserver {
    
    func start()
    
    var delegates:MulticastDelegate<ApplicationStateHandlerDelegate> {get}
    
}

protocol ApplicationStateHandlerDelegate:class {
    func applicationWillEnterForeground()
}

class DefaultApplicationStateHandler : ApplicationStateObserver {
    
    var delegates: MulticastDelegate = MulticastDelegate<ApplicationStateHandlerDelegate>()
    
    
    func start() {
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(enteringForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter
            .default
            .removeObserver(self)
    }
    
    func addDelegate(_ delegate: ApplicationStateHandlerDelegate) {
        delegates.addDelegate(delegate)
    }
    
    func removeDelegate(_ delegate: ApplicationStateHandlerDelegate) {
        delegates.removeDelegate(delegate)
    }
    
}

private extension DefaultApplicationStateHandler {
    
    @objc func enteringForeground() {
        delegates.invoke(invocation: {$0.applicationWillEnterForeground()})
    }
    
}
