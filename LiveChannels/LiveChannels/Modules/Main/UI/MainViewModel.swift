//
//  MainViewModel.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine
import UIKit

typealias LiveChannelsViewData = TypedTask<LiveChannelsBasicData>

struct LiveChannelsBasicData {
    let channels: [Channel]
    let currentTime: Int
}

class MainViewModel: BaseViewModel, ObservableObject {
    
    @Published var liveChannelsViewData: LiveChannelsViewData = LiveChannelsViewData()
    
    func getLiveChannels() {
        self.liveChannelsViewData = LiveChannelsViewData(status: .running)
        apiClient.getLiveChannels()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.liveChannelsViewData = LiveChannelsViewData(status: .error)
                }
            } receiveValue: { (liveChannels: LiveChannels) in
                let liveChannelsBasicData: LiveChannelsBasicData = LiveChannelsBasicData(
                    channels: liveChannels.channels.sorted { $0.id < $1.id }, currentTime: liveChannels.currentTime)
                self.liveChannelsViewData = LiveChannelsViewData(status: .success, data: liveChannelsBasicData)
            }.store(in: &cancellables)
    }
    
    func isChannelAvailableToOpen(liveProgramId: String) -> Bool {
        Constants.availableChannelsToOpen.contains(liveProgramId)
    }
}
