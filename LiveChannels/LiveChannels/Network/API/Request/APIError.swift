//
//  APIError.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String),
         parserError(reason: String),
         expiredSubscription,
         undefined

    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error"
            case .undefined:
                return "Undefined API"
            case .apiError(let reason), .parserError(let reason):
                return reason
            case .expiredSubscription:
                return "expiredSubscription"
        }
    }
}
