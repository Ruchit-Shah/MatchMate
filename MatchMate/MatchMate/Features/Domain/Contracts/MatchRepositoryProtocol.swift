//
//  MatchRepositoryProtocol.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

protocol MatchRepositoryProtocol {
    func fetchMatches() async throws -> [MatchProfile]
    func updateStatus(for profileId: String, to status: MatchStatus) async throws
}
