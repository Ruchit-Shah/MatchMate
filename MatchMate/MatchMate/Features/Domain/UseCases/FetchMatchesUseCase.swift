//
//  FetchMatchesUseCase.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

final class FetchMatchesUseCase {
    private let repository: MatchRepositoryProtocol

    init(repository: MatchRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [MatchProfile] {
        try await repository.fetchMatches()
    }
}

