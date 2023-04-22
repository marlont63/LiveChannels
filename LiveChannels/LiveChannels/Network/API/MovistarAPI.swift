//
//  MovistarAPI.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine

protocol MovistarAPI {
    func getLiveChannels() -> AnyPublisher<Channels, Error>
}


extension MovistarAPI {
    func getLiveChannels() -> AnyPublisher<Channels, Error> {
        return URLSession.shared.publisher(using: GetLiveChannelsRequest())
    }
}
 
