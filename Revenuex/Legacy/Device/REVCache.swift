//
//  DeviceManager.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 8.04.2021.
//

import UIKit

class REVCache {

    private var userDefaults:UserDefaults
    
    init (userDefaults:UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    
    var applicationUserId:String? {
        set {self.userDefaults.setValue(newValue, forKey: "applicationUserId")}
        get {return self.userDefaults.string(forKey: "applicationUserId")}
    }
    
}
