//
//  MainViewModel.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine
import UIKit

class MainViewModel: BaseViewModel, ObservableObject {
    
    @Published var liveChannels: Channels?
    
    func getLiveChannels() {
        apiClient.getLiveChannels()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("TODO: error \(error.localizedDescription)")
                }
            } receiveValue: { (channels: Channels) in
                self.liveChannels = channels
            }.store(in: &cancellables)
    }
}
