//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Ruchit on 09/06/26.
//

import SwiftUI

@main
struct MatchMateApp: App {
    private let appCoordinator = AppCoordinator(container: DependencyContainer())

    var body: some Scene {
        WindowGroup {
            appCoordinator.rootView()
        }
    }
}
