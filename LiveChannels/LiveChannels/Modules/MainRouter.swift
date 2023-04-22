//
//  MainRouter.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 21/4/23.
//

import Foundation
import SwiftUI
import Combine

public enum PublicPages {
    case mainScreen
    case channelDetailsScreen
}

public enum GenericAlerts {
    case genericError(accept: () -> ())
}

// Top level navigation graph
class NavigationGraph: ObservableObject {

    @Published var currentPage: PublicPages
    @Published var present: Bool /// FIXME: transform to a LIFO structure
    @Published var alert: Bool
    @Published var targetView: AnyView
    @Published var alertView: Alert
    @Environment(\.openURL) var openURL
    
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    init() {
        currentPage = .mainScreen
        present = false
        alert = false
        targetView = EmptyView().eraseToAnyView()
        alertView = Alert(title: Text(""))
    }

    var viewStack: Stack<AnyView> = Stack<AnyView>()

    // MARK: - Screens
    lazy var mainScreen: MainScreen = {
        toMainScreen()
    }()
    
    func genericAlertScreen(accept: @escaping () -> ()) -> Alert {
        Alert(title: Text("Se ha producido un error"), message: Text("Por favor, inténtalo más tarde."), dismissButton: .default(Text("Ok".capitalized), action: {
            self.alert = false
            accept()
        }))
    }

    // MARK: - ViewModels
    lazy var mainViewModel: MainViewModel = {
        MainViewModel()
    }()
    
    // MARK: - Navigation

    // Use this method to navigate instead of set `privatePage` or `currentPage` directly
    func go(to publicPage: PublicPages) {
        self.currentPage = publicPage
    }

    private func view(for publicPages: PublicPages) -> AnyView {
        switch publicPages {
        case .mainScreen:
            return mainScreen.eraseToAnyView()
        case .channelDetailsScreen:
            return EmptyView().eraseToAnyView()
        }
    }

    // Use this function to present modally the view that corresponds to PrivatePage `view`
    func present(view: PublicPages, orientation: UIInterfaceOrientationMask = .portrait) {
        self.present(view: self.view(for: view), orientation: orientation)
    }

    // Use this function to present modally the view `view`
    func present(view: AnyView, orientation: UIInterfaceOrientationMask = .portrait, delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.viewStack.push(view)
            self.targetView = self.viewStack.peek()!.eraseToAnyView()
            self.present = true
        }
    }

    // If any view is presented this function dismiss the view
    func dismiss(orientation: UIInterfaceOrientationMask = .portrait) {
        _ = viewStack.pop()
        if let newTargetView: AnyView = viewStack.pop() {
            present(view: newTargetView, orientation: orientation)
        } else {
            present = false
        }
    }
    
    func removeAllViews() {
        viewStack.array.removeAll()
    }

    // This function present an alert defined by `GenerycAlerts`
    // - Warning: all targetViews must reset `self.alert` value to `false` to allow other to be pressented..
    func show(alert: GenericAlerts) {
        switch alert {
            case let .genericError(accept):
            self.alertView = genericAlertScreen(accept: {
                accept()
            })
        }
        self.alert = true
    }

    // MARK: - Constructors
    
    private func toMainScreen() -> MainScreen {
        MainScreen(mainViewModel: mainViewModel)
    }
}
