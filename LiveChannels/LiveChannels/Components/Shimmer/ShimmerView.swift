//
//  ShimmerView.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation
import SwiftUI

public struct ShimmerView: View {
    @State private var opacity: Double = 0.25
    public init() {}

    public var body: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .fill(Color.gray)
            .opacity(opacity)
            .transition(.opacity)
            .redacted(reason: .placeholder)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = 1.0
                }
            }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            ShimmerView()
                .frame(width: UIScreen.main.bounds.width / 2, height: 20)
            ShimmerView()
                .frame(width: UIScreen.main.bounds.width / 2, height: 20)
            ShimmerView()
                .frame(height: 52)
            ShimmerView()
                .frame(height: 52)
            Spacer()
        }.padding()
    }
}
