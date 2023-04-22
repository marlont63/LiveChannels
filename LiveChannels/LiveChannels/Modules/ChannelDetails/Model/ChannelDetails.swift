//
//  ChannelDetails.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation

struct ChannelDetails: Codable {
    let id: Int
    let cover: String
    let title: String
    let category: String
    let endTime: String
    let startTime: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cover
        case title
        case category
        case endTime = "end_time"
        case startTime = "start_time"
        case description
    }
}
