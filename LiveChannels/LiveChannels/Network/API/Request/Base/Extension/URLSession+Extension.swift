//
//  URLSession+Extension.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine

extension URLSession {
    enum URLError:Error {
        case InvalidEndpointError
    }
    
    func publisher<R:Decodable>(
        using requestData: Request,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<R, Error> {
        
        // Show Request log
        requestData.urlRequest.showLog()
        
        return dataTaskPublisher(for: requestData.urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw URLError.InvalidEndpointError
                }
                
                // Show Response log
                httpResponse.showLog(from: element.data)
                switch httpResponse.statusCode {
                case 200..<300:
                    return element.data
                default:
                    throw URLError.InvalidEndpointError
                }
            }
            .decode(type: R.self, decoder: decoder)
            .mapError { error in
                if let error = error as? DecodingError {
                    var errorToReport = error.localizedDescription
                    switch error {
                    case .dataCorrupted(let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) - (\(details))"
                    case .keyNotFound(let key, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
                    case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
                    @unknown default:
                        break
                    }
                    return APIError.parserError(reason: errorToReport)
                }  else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


