//
//  MatchCardContainer.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Foundation

final class MatchCardContainer {
    private let coreDataStack: CoreDataStackProtocol
    private let networkService: NetworkServiceProtocol
    private let networkMonitor: NetworkMonitorProtocol

    init(
        coreDataStack: CoreDataStackProtocol,
        networkService: NetworkServiceProtocol,
        networkMonitor: NetworkMonitorProtocol
    ) {
        self.coreDataStack = coreDataStack
        self.networkService = networkService
        self.networkMonitor = networkMonitor
    }

    // MARK: - Factories

    func makeCoordinator() -> MatchCardCoordinator {
        MatchCardCoordinator(viewModel: makeViewModel())
    }

    func makeViewModel() -> MatchListViewModel {
        let remoteDataSource = MatchRemoteDataSource(networkService: networkService)
        let localDataSource = MatchLocalDataSource(coreDataStack: coreDataStack)
        let repository = MatchRepository(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            networkMonitor: networkMonitor
        )
        let fetchUseCase = FetchMatchesUseCase(repository: repository)
        let updateUseCase = UpdateMatchStatusUseCase(repository: repository)
        return MatchListViewModel(
            fetchMatchesUseCase: fetchUseCase,
            updateMatchStatusUseCase: updateUseCase,
            networkMonitor: networkMonitor
        )
    }
}

