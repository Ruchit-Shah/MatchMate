//
//  MatchCardCoordinator.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Combine
import SwiftUI

final class MatchCardCoordinator: ObservableObject {
    @Published var path: [MatchCardRoute] = []

    private let viewModel: MatchListViewModel

    init(viewModel: MatchListViewModel) {
        self.viewModel = viewModel
    }

    func start() -> some View {
        MatchCardCoordinatorView(coordinator: self)
    }

    @ViewBuilder
    func destination(for route: MatchCardRoute) -> some View {
        switch route {
        case .list:
            MatchListView(viewModel: viewModel)
        }
    }
}

// MARK: - Coordinator View

private struct MatchCardCoordinatorView: View {
    @ObservedObject var coordinator: MatchCardCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.destination(for: .list)
                .navigationDestination(for: MatchCardRoute.self) { route in
                    coordinator.destination(for: route)
                }
        }
    }
}
