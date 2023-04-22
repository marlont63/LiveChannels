//
//  Request.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation

typealias API = (MovistarAPI)

// Rest available `methods`
public enum RequestMethod: String {
    
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
    var description:String {
        return self.rawValue
    }
}

// Minimal request params to make a `REST` request
protocol Request {
    var urlRequest: URLRequest { get }
    var endpoint: String { get }
    var path:String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any]? { get set }
    var queryItems:[URLQueryItem] { get set }
    var headers: [String: String] { get }
}


extension Request {
    var endpoint: String { "https://api.npoint.io/f5552c061b8cf68cffa0/\(path)"}
    
    var urlRequest: URLRequest {
        var components:URLComponents = URLComponents(string: self.endpoint)!
        components.queryItems = queryItems
        let url: URL! = components.url!
        var urlRequest = URLRequest(url: url)
        for header in self.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        urlRequest.httpMethod = self.method.description
        switch self.method {
        case .post:
            self.addBody(toRequest: &urlRequest)
        case .put:
            self.addBody(toRequest: &urlRequest)
        default:
            break
        }
        return urlRequest
    }
    
    // Rest request headers, by default `application/json` is defined
    var headers: [String: String] {
        
        let localHeaders:[String:String] = ["Content-Type": "application/json; charset=UTF-8"]
        return localHeaders
    }
    
    // body params in a `put` or  `post` request
    var parameters: [String: Any]? {
        return nil
    }
        
    // Add `parameters` as a body in the request
    internal func addBody(toRequest: inout URLRequest) {
       toRequest.httpBody = try? self.paramsAsJSONBody()
    }
    
    // Method to `attach` header params to a request
    internal func add(headers:[String:String], toRequest: inout URLRequest) {
        for header in headers {
            toRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    // If request body needs the `content as a JSON` use this method
    internal func paramsAsJSONBody() throws -> Data? {
        if let paramsUnwrapped:[String:Any] = self.parameters {
            return try JSONSerialization.data(withJSONObject: paramsUnwrapped)
        }
        return nil
    }
}
