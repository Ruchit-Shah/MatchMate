//
//  NetworkMonitor.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import Combine
import Foundation
import Network

final class NetworkMonitor: NetworkMonitorProtocol {
    @Published private var connected: Bool
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    var isConnected: Bool { connected }

    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        $connected
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    init(queue: DispatchQueue = DispatchQueue(label: "com.matchmate.networkmonitor")) {
        self.monitor = NWPathMonitor()
        self.queue = queue
        self.connected = true
    }

    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isSatisfied = path.status == .satisfied
            DispatchQueue.main.async {
                self?.connected = isSatisfied
            }
        }
        monitor.start(queue: queue)
    }

    func stop() {
        monitor.cancel()
    }

    deinit {
        monitor.cancel()
    }
}
