//
//  NetworkErrorLogger.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 29.04.2021.
//

import Foundation

protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    init() { }

    func log(request: URLRequest) {
        print("-------------")
        print("Request: \(request.url!)")
        print("Headers: \(request.allHTTPHeaderFields!)")
        print("Method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("Body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("Body: \(String(describing: resultString))")
        }
    }

    func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("Response: \(String(describing: dataDict))")
        }
    }

    func log(error: Error) {
        printIfDebug("\(error)")
    }
}
