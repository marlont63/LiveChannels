//
//  ContentRequests.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation

struct GetLiveChannelsRequest: Request {
    var path: String {
        "f5552c061b8cf68cffa0/"
    }
    var parameters: [String : Any]?
    var queryItems: [URLQueryItem] = [URLQueryItem]()
    var method: RequestMethod {
        .get
    }
}

struct GetLiveChannelDetailsReuqest: Request {
    var path: String {
        "f3c6446abeb1c5a82079"
    }
    var parameters: [String : Any]?
    var queryItems: [URLQueryItem] = [URLQueryItem]()
    var method: RequestMethod {
        .get
    }
}
