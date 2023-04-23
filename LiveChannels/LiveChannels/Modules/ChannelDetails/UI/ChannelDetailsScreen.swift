//
//  ChannelDetailsScreen.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation
import SwiftUI

struct ChannelDetailsScreen: View {
    
    @ObservedObject var channelDetailsViewModel: ChannelDetailsViewModel
    var goBack: () -> Void
    var showGenericError: () -> Void
    
    var body: some View {
        VStack(spacing: .zero) {
            switch channelDetailsViewModel.channelDetailsViewData.status {
            case .running:
                LoadingView()
            case .success:
                if let channelDetails: ChannelDetails = channelDetailsViewModel.channelDetailsViewData.data {
                    HStack(spacing: .zero) {
                        Text(channelDetails.title)
                            .font(
                                .custom("AmericanTypewriter", fixedSize: 34)
                                .weight(.heavy)
                            )
                            .padding(.leading, 16)
                        Spacer()
                        Button(action: {
                            self.goBack()
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 16)
                        }
                    }
                    .padding(.top, 50)
                    
                    VStack(spacing: .zero) {
                        HStack(spacing: .zero) {
                            if let coverURL: URL = URL(string: channelDetails.cover) {
                                ImageFromUrl(url: coverURL, isGeometryFrameUsed: true)
                                    .frame(width: 300, height: 300)
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        
                        let liveProgramPercentage: Double = channelDetailsViewModel.getLiveProgramPercentage(
                            startTime: channelDetails.startTime,
                            endTime: channelDetails.endTime,
                            currentTime: channelDetailsViewModel.currentTime)
                        
                        HStack(spacing: .zero) {
                            Spacer()
                            Text("Progreso: \(Int(liveProgramPercentage * 100)) %")
                                .font(
                                    .custom("AmericanTypewriter", fixedSize: 15)
                                )
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 3)
                        
                        LinearProgressBar(
                            value: liveProgramPercentage,
                            maxValue: Constants.totalProgress,
                            backgroundColor: .gray,
                            foregroundColor: .green
                        )
                        .frame(height: 10)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: .zero) {
                            Text(channelDetails.startTime.stringToDate())
                                .font(
                                    .custom("AmericanTypewriter", fixedSize: 15)
                                )
                                .foregroundColor(.black)
                            Spacer()
                            Text(channelDetails.endTime.stringToDate())
                                .font(
                                    .custom("AmericanTypewriter", fixedSize: 15)
                                )
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 15)
                        
                        
                        Group {
                            Text(channelDetails.description)
                                .multilineTextAlignment(.center)
                                .font(.custom("AmericanTypewriter", fixedSize: 16))
                                .padding(.horizontal, 16)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 35)
                }
            case .error:
                Spacer()
            case .idle:
                Spacer()
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            channelDetailsViewModel.getChannelDetails()
        }
    }
}
