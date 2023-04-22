//
//  LiveChannelsApp.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import SwiftUI

@main
struct LiveChannelsApp: App {
    @StateObject var navigationGraph: NavigationGraph = NavigationGraph()
    
    var body: some Scene {
        WindowGroup {
            MotherView(navigationGraph: navigationGraph)
        }
    }
}


struct MotherView: View {
    @ObservedObject var navigationGraph: NavigationGraph
    
    var body: some View {
        ZStack {
            view()
               .fullScreenCover(isPresented: $navigationGraph.present, content: {
                   ZStack {
                       navigationGraph.targetView
                           .ignoresSafeArea()
                           .edgesIgnoringSafeArea(.top)
                           .alert(isPresented: $navigationGraph.alert, content: {
                           navigationGraph.alertView
                       })
                   }
               })
               .alert(isPresented: $navigationGraph.alert, content: {
                   navigationGraph.alertView
               })
        }
    }

    private func view() -> AnyView {
        return navigationGraph.mainScreen.eraseToAnyView()
    }
}
