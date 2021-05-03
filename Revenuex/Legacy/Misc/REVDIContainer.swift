//
//  REVREVDIContainer.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 8.04.2021.
//

import UIKit

protocol REVREVDIContainerProtocol {
  func register<Component>(type: Component.Type, component: Any)
  func resolve<Component>(type: Component.Type) -> Component?
}

final class REVDependencyContainer: REVREVDIContainerProtocol {
  
  static let shared = REVDependencyContainer()
  private init() {}

  var components: [String: Any] = [:]

  func register<Component>(type: Component.Type, component: Any) {
    components["\(type)"] = component
  }

  func resolve<Component>(type: Component.Type) -> Component? {
    return components["\(type)"] as? Component
  }
}
