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
    
    var delegate:ApplicationStateObserverDelegate {get}
    
}

protocol ApplicationStateObserverDelegate:class {
    func applicationWillEnterForeground()
}

class DefaultApplicationStateObserver : ApplicationStateObserver {
    
    var delegate: ApplicationStateObserverDelegate
    
    init(delegate: ApplicationStateObserverDelegate) {
        self.delegate = delegate
    }
    
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
    
    
}

private extension DefaultApplicationStateObserver {
    
    @objc func enteringForeground() {
        delegate.applicationWillEnterForeground()
    }
    
}
