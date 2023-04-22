//
//  BaseViewModel.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import Combine

/**
 * Base class for viewModels to inherit common values and functions
 */
public class BaseViewModel: NSObject {
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    let apiClient: API = APIClient()

    func cancelAll() {
        for cancelable in self.cancellables {
            cancelable.cancel()
        }
    }
    
    func getLiveProgramPercentage(startTime: String, endTime: String, currentTime: Int) -> Double {
        (currentTime.double - startTime.double) / (endTime.double - startTime.double)
    }
}

struct APIClient: API {}
