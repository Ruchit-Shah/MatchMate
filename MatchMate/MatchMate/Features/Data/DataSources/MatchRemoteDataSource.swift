//
//  MatchRemoteDataSource.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Foundation

protocol MatchRemoteDataSourceProtocol {
    func fetchUsers() async throws -> [RandomUserDTO]
}

final class MatchRemoteDataSource: MatchRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    private let resultCount: Int

    init(networkService: NetworkServiceProtocol, resultCount: Int = 10) {
        self.networkService = networkService
        self.resultCount = resultCount
    }

    func fetchUsers() async throws -> [RandomUserDTO] {
        let endpoint = Endpoint(
            queryItems: [URLQueryItem(name: "results", value: String(resultCount))]
        )
        let response: RandomUserResponseDTO = try await networkService.request(endpoint: endpoint)
        return response.results
    }
}
