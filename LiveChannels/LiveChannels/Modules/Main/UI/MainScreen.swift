//
//  MainScreen.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack() {
            ScrollView(.vertical, showsIndicators: false) {
                if let channels: [Channel] = mainViewModel.liveChannels?.channels {
                    ForEach(channels, id: \.id) { channel in
                        HStack(spacing: .zero) {
                            VStack(spacing: .zero) {
                                Text(channel.name)
                                Text(channel.liveProgram.startTime)
                                Text(channel.liveProgram.endTime)
                            }
                        }
                        .cornerRadius(4.0)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .padding(.bottom, 5)
                        .padding(.horizontal, 16)
                    }
                }
            }
            
//            Color.red
//            HStack(spacing: .zero) {
//                Text("Total Channels \(mainViewModel.liveChannels?.channels.count ?? 0)")
//            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            mainViewModel.getLiveChannels()
        })
    }
}
