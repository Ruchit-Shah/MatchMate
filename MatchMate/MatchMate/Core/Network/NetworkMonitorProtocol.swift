//
//  NetworkMonitorProtocol.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Combine
import Foundation

protocol NetworkMonitorProtocol: AnyObject {
    var isConnected: Bool { get }
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
    func start()
    func stop()
}

