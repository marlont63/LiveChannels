//
//  ContentRequests.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation

struct GetLiveChannelsRequest: Request {
    var path: String {
        ""
    }
    var queryItems: [URLQueryItem] = [URLQueryItem]()
    var parameters: [String: Any]?
    var method: RequestMethod {
        .get
    }
}
