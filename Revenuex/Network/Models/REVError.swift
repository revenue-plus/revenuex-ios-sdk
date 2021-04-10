//
//  REVError.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 6.04.2021.
//

import UIKit

///MARK- REVError
enum REVError: Error {
    
    /// `REVRequest` threw an error during the encoding process.
    case parameterEncodingFailed(reason: REVParameterEncodingFailureReason)
    
    /// Api request failed.
    case responseError(reason: REVResponseErrorReason)
    
    /// Network Error
    case networkError(error: Error)
    
    /// Unknown error.
    case unknown
    
    
}

extension REVError:LocalizedError {
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
public enum REVParameterEncodingFailureReason {
    
    /// The `URLRequest` did not have a `URL` to encode.
    case missingURL
}

extension REVParameterEncodingFailureReason:LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingURL:
            return "URL request to encode was missing a URL"
        }
    }
}


///MARK- REVResponseErrorReason

public enum REVResponseErrorReason {
    
    /// Http response code not specified by any standard.
    case unofficialHttpStatusCode(code: Int)
    
    /// The server response contained no data or the data was zero length.
    case inputDataNilOrZeroLength
    
    /// A `DataDecoder` failed to decode the response due to the associated `Error`.
    case decodingFailed(error: Error)
    
    ///  The error seems to have been caused by the client.
    case clientError(response:REVErrorResponse?)
    
    /// Indicate cases in which the server is aware that it has encountered an error or is otherwise incapable of performing the request.
    case serverError(response:REVErrorResponse?)
}

extension REVResponseErrorReason:LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unofficialHttpStatusCode(let code):
            return "Status code \(code) not specified by any standard."
        case .clientError(let response),
             .serverError(let response):
            return response?.localizedDescription
        case .decodingFailed(let error):
            return "Response could not be decoded because of error:\n\(error.localizedDescription)"
        case .inputDataNilOrZeroLength:
            return "Response could not be serialized, input data was nil or zero length."
        }
    }
}



