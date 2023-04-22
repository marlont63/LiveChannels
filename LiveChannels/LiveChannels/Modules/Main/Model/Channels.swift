//
//  Channels.swift
//  LiveChannels
//
//  Created by Marlon Raschid Tavarez Parra on 22/04/2023.
//

import Foundation

struct LiveChannels: Codable {
    let channels: [Channel]
    let currentTime: Int
}
