//
//  NetworkServiceProtocol.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
