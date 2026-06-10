//
//  DependencyContainer.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Foundation

final class DependencyContainer {
    // MARK: - Core Infrastructure

    let coreDataStack: CoreDataStackProtocol
    let networkService: NetworkServiceProtocol
    let networkMonitor: NetworkMonitorProtocol

    // MARK: - Feature Containers

    lazy var matchCardContainer = MatchCardContainer(
        coreDataStack: coreDataStack,
        networkService: networkService,
        networkMonitor: networkMonitor
    )

    // MARK: - Init

    init(
        coreDataStack: CoreDataStackProtocol = CoreDataStack(),
        networkService: NetworkServiceProtocol = NetworkService(),
        networkMonitor: NetworkMonitorProtocol = NetworkMonitor()
    ) {
        self.coreDataStack = coreDataStack
        self.networkService = networkService
        self.networkMonitor = networkMonitor
    }
}
