//
//  MovistarAPI.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine

protocol MovistarAPI {
    func getLiveChannels() -> AnyPublisher<LiveChannels, Error>
    func getLiveChannelDetails() -> AnyPublisher<ChannelDetails, Error>
}


extension MovistarAPI {
    func getLiveChannels() -> AnyPublisher<LiveChannels, Error> {
        return URLSession.shared.publisher(using: GetLiveChannelsRequest())
    }
    
    func getLiveChannelDetails() -> AnyPublisher<ChannelDetails, Error> {
        return URLSession.shared.publisher(using: GetLiveChannelDetailsReuqest())
    }
}
 
