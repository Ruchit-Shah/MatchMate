//
//  MatchRepository.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Foundation

final class MatchRepository: MatchRepositoryProtocol {
    private let remoteDataSource: MatchRemoteDataSourceProtocol
    private let localDataSource: MatchLocalDataSourceProtocol
    private let networkMonitor: NetworkMonitorProtocol

    init(
        remoteDataSource: MatchRemoteDataSourceProtocol,
        localDataSource: MatchLocalDataSourceProtocol,
        networkMonitor: NetworkMonitorProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.networkMonitor = networkMonitor
    }

    // MARK: - MatchRepositoryProtocol

    func fetchMatches() async throws -> [MatchProfile] {
        guard networkMonitor.isConnected else {
            return try await localDataSource.fetchAll()
        }

        do {
            let dtos = try await remoteDataSource.fetchUsers()
            let profiles = MatchProfileMapper.map(dtos)
            try await localDataSource.save(profiles: profiles)
            return try await localDataSource.fetchAll()
        } catch {
            return try await localDataSource.fetchAll()
        }
    }

    func updateStatus(for profileId: String, to status: MatchStatus) async throws {
        try await localDataSource.updateStatus(for: profileId, to: status)
    }
}
