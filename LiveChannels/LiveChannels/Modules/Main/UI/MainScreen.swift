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
    var goToDetailView: (_ currentTime: Int) -> Void
    var showGenericError: () -> Void
    
    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(.vertical, showsIndicators: false) {
                switch mainViewModel.liveChannelsViewData.status {
                case .running:
                    LoadingView()
                case .success:
                    if let liveChannelsBasicData: LiveChannelsBasicData = mainViewModel.liveChannelsViewData.data {
                        ForEach(liveChannelsBasicData.channels, id: \.id) { (channel: Channel) in
                            ChannelCardView(
                                channel: channel,
                                liveProgramPercentage: mainViewModel.getLiveProgramPercentage(
                                    startTime: channel.liveProgram.startTime,
                                    endTime: channel.liveProgram.endTime,
                                    currentTime: liveChannelsBasicData.currentTime
                                )
                            )
                            .onTapGesture {
                                if mainViewModel.isChannelAvailableToOpen(liveProgramId: "\(channel.liveProgram.id)") {
                                    goToDetailView(liveChannelsBasicData.currentTime)
                                } else {
                                    showGenericError()
                                }
                            }
                        }
                    }
                case .error:
                    Spacer()
                        .onAppear() {
                            showGenericError()
                        }
                case .idle:
                    Spacer()
                }
            }
            .padding(.top, 80)
        }
        .padding(.bottom, 50)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            mainViewModel.getLiveChannels()
        })
    }
}

struct ChannelCardView: View {
    
    var channel: Channel
    var liveProgramPercentage: Double
    
    var body: some View {
        HStack(spacing: .zero) {
            if let imageURL: URL = URL(string: channel.logo) {
                ImageFromUrl(url: imageURL, isGeometryFrameUsed: true)
                    .frame(width: 50, height: 50)
                    .padding(.leading, 10)
            }
            VStack(alignment: .leading, spacing: .zero) {
                Text(channel.name)
                    .font(
                        .largeTitle
                        .weight(.bold)
                    )
                    .foregroundColor(.white)
                Text(channel.liveProgram.title)
                    .font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                HStack(spacing: .zero) {
                    Spacer()
                    Text("Progreso: \(Int(liveProgramPercentage * 100)) %")
                        .font(
                            .custom("AmericanTypewriter", fixedSize: 10)
                        )
                        .foregroundColor(.white)
                }
                .padding(.bottom, 3)
                LinearProgressBar(
                    value: liveProgramPercentage,
                    maxValue: Constants.totalProgress,
                    backgroundColor: .gray,
                    foregroundColor: .green
                )
                .frame(height: 6)
                .padding(.bottom, 3)
                
                HStack(spacing: .zero) {
                    Text(channel.liveProgram.startTime.stringToDate())
                        .font(
                            .custom("AmericanTypewriter", fixedSize: 10)
                        )
                        .foregroundColor(.white)
                    Spacer()
                    Text(channel.liveProgram.endTime.stringToDate())
                        .font(
                            .custom("AmericanTypewriter", fixedSize: 10)
                        )
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical , 10)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.8))
        .cornerRadius(4.0)
        .padding(.bottom, 5)
        .padding(.horizontal, 16)
    }
}
