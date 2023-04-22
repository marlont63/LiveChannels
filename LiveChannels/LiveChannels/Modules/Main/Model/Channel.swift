//
//  Channel.swift
//  LiveChannels
//
//  Created by Marlon Raschid Tavarez Parra on 22/04/2023.
//

import Foundation

struct Channel: Codable {
    let id: Int
    let title: String?
    let name: String
    let liveProgram: LiveProgram
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case liveProgram = "live_program"
    }
}
