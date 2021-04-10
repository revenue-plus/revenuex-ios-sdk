//
//  ResponseSerializationFailureReason.swift
//  Revenuex
//
//  Created by Orhan DALGARA on 7.04.2021.
//

import UIKit

public enum REVResponseSerializationFailureReason {
    
    /// The server response contained no data or the data was zero length.
    case inputDataNilOrZeroLength
    /// String serialization failed using the provided `String.Encoding`.
    case stringSerializationFailed(encoding: String.Encoding)
    /// JSON serialization failed with an underlying system error.
    case jsonSerializationFailed(error: Error)
    /// A `DataDecoder` failed to decode the response due to the associated `Error`.
    case decodingFailed(error: Error)
    /// A custom response serializer failed due to the associated `Error`.
    case customSerializationFailed(error: Error)
    /// Generic serialization failed for an empty response that wasn't type `Empty` but instead the associated type.
    case invalidEmptyResponse(type: String)
}
