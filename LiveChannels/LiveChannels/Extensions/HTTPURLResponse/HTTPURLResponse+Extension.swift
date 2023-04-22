//
//  HTTPURLResponse+Extension.swift
//  LiveChannels
//
//  Created by Marlon Raschid Tavarez Parra on 21/04/2023.
//

import Foundation

extension HTTPURLResponse {
    func showLog(from data: Data?) {
        var body: String?

        if let json = data {
            body = String(data: json, encoding: .utf8)
        }

        var headers: [String: Any] = [:]
        for (key, value) in allHeaderFields {
            headers[key as! String] = value
        }

        let logMessage =
           """
           ====== RESPONSE ======
           STATUS CODE: \(statusCode.description)
           HEADERS: \(headers)
           BODY: \(body ?? "EMPTY RESPONSE")
           """
           print(logMessage)
    }
}
