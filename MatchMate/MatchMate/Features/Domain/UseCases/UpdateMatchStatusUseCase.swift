//
//  UpdateMatchStatusUseCase.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

final class UpdateMatchStatusUseCase {
    private let repository: MatchRepositoryProtocol

    init(repository: MatchRepositoryProtocol) {
        self.repository = repository
    }

    func execute(profileId: String, status: MatchStatus) async throws {
        try await repository.updateStatus(for: profileId, to: status)
    }
}

