//
//  LiveProgram.swift
//  LiveChannels
//
//  Created by Marlon Raschid Tavarez Parra on 22/04/2023.
//

import Foundation

struct LiveProgram: Codable {
    let id: Int
    let title: String
    let endTime: String
    let startTime: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case endTime = "end_time"
        case startTime = "start_time"
    }
}
