//
//  REVREVDIContainer.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 8.04.2021.
//

import UIKit

@propertyWrapper
struct Dependency<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = REVDependencyContainer.resolve()
    }
}


final class REVDependencyContainer {
  
    private var dependencies = [String: AnyObject]()
    private static var shared = REVDependencyContainer()

    static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        precondition(dependency != nil, "No dependency found for \(key)! must register a dependency before resolve.")

        return dependency!
    }
}
