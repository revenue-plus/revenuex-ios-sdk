//
//  REVError.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit

enum APIError: Error {

    /// `REVRequest` threw an error during the encoding process.
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

    /// Api request failed.
    case responseError(reason: ResponseErrorReason)

    /// Network Error
    case networkError(error: Error)
    
    /// Unknown error.
    case unknown


}

extension APIError:LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason.localizedDescription
        case .responseError(let reason):
            return reason.localizedDescription
        case .networkError(let error):
            return error.localizedDescription
        case .unknown:
            return nil
        }
    }
}

///MARK- REVParameterEncodingFailureReason
public enum ParameterEncodingFailureReason {

    /// The `URLRequest` did not have a `URL` to encode.
    case missingURL
}

extension ParameterEncodingFailureReason:LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingURL:
            return "URL request to encode was missing a URL"
        }
    }
}


///MARK- REVResponseErrorReason

public enum ResponseErrorReason {

    case unexpectedResponse
    
    case unexpectedHttpCode(code: Int, responseData:Data?)

    case inputDataNilOrZeroLength
    
    case decodingFailed(error: Error)


}

extension ResponseErrorReason:LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpectedResponse:
            return "Unexpected response"
        case .unexpectedHttpCode(let code, _):
            return "Unexpected HTTP code: \(code)"
        case .decodingFailed(let error):
            return "Response could not be decoded because of error:\n\(error.localizedDescription)"
        case .inputDataNilOrZeroLength:
            return "Response could not be serialized, input data was nil or zero length."
        }
    }
}



