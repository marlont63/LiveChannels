//
//  ChannelDetailsViewModel.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation
import Combine

typealias ChannelDetailsViewData = TypedTask<ChannelDetails>

class ChannelDetailsViewModel: BaseViewModel, ObservableObject {
    
    @Published var channelDetailsViewData: ChannelDetailsViewData = ChannelDetailsViewData()
    let currentTime: Int
    
    init(currentTime: Int) {
        self.currentTime = currentTime
    }
    
    func getChannelDetails() {
        apiClient.getLiveChannelDetails()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.channelDetailsViewData = ChannelDetailsViewData(status: .error, error: error)
                case .finished:
                    break
                }
            } receiveValue: { (channelDetail: ChannelDetails) in
                self.channelDetailsViewData = ChannelDetailsViewData(status: .success, data: channelDetail)
            }.store(in: &self.cancellables)
    }
    
    func resetViewModel() {
        cancelAll()
    }
}
