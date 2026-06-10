//
//  AppCoordinator.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import SwiftUI

final class AppCoordinator {
    private let container: DependencyContainer
    private let matchCardCoordinator: MatchCardCoordinator

    init(container: DependencyContainer) {
        self.container = container
        self.matchCardCoordinator = container.matchCardContainer.makeCoordinator()
    }
    func rootView() -> some View {
        matchCardCoordinator.start()
    }
}
