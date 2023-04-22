//
//  URLRequest+Extension.swift
//  LiveChannels
//
//  Created by Marlon Raschid Tavarez Parra on 21/04/2023.
//

import Foundation

extension URLRequest {
    func showLog() {
        var body: String?
        if let json = httpBody {
            body = String(data: json, encoding: .utf8)
        }

        let logMessage =
           """
           ====== REQUEST ======
           Method: \(httpMethod ?? "NOT DEFINED")
           URL: \(url?.absoluteString ?? "NOT DEFINED")
           HEADERS: \(allHTTPHeaderFields?.description ?? "NOT DEFINED")
           BODY: \(body ?? "NOT DEFINED")
           """
           print(logMessage)
    }
}
