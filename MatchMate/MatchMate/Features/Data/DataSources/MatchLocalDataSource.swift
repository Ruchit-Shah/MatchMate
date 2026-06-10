//
//  MatchLocalDataSource.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import CoreData
import Foundation
import os

protocol MatchLocalDataSourceProtocol {
    func fetchAll() async throws -> [MatchProfile]
    func save(profiles: [MatchProfile]) async throws
    func updateStatus(for profileId: String, to status: MatchStatus) async throws
}
final class MatchLocalDataSource: MatchLocalDataSourceProtocol {
    private let coreDataStack: CoreDataStackProtocol
    private let logger = Logger(subsystem: "com.matchmate", category: "MatchLocalDataSource")

    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Read

    func fetchAll() async throws -> [MatchProfile] {
        let context = coreDataStack.viewContext
        return try await context.perform {
            let request = MatchEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "fetchedAt", ascending: true)]
            let entities = try context.fetch(request)
            return entities.compactMap(MatchProfileMapper.map)
        }
    }

    // MARK: - Write

    func save(profiles: [MatchProfile]) async throws {
        guard !profiles.isEmpty else { return }

        let context = coreDataStack.newBackgroundContext()
        try await context.perform {
            for profile in profiles {
                let entity = try self.existingEntity(withID: profile.id, in: context)
                    ?? MatchEntity(context: context)

                if entity.id == nil || entity.id?.isEmpty == true {
                    // Newly created entity: populate everything (status from profile).
                    MatchProfileMapper.apply(profile, to: entity)
                } else {
                    // Existing entity: refresh fields but preserve the user's decision.
                    let existingStatus = MatchStatus(rawValue: entity.status ?? "") ?? .none
                    MatchProfileMapper.apply(profile, to: entity)
                    entity.status = existingStatus.rawValue
                }
                entity.fetchedAt = Date()
            }

            if context.hasChanges {
                try context.save()
            }
        }
    }

    func updateStatus(for profileId: String, to status: MatchStatus) async throws {
        let context = coreDataStack.newBackgroundContext()
        try await context.perform {
            guard let entity = try self.existingEntity(withID: profileId, in: context) else {
                self.logger.error("updateStatus: no profile found for id \(profileId, privacy: .public)")
                return
            }
            entity.status = status.rawValue
            if context.hasChanges {
                try context.save()
            }
        }
    }

    // MARK: - Helpers

    /// Fetches the single entity matching `id`, or `nil` when none exists.
    private func existingEntity(withID id: String, in context: NSManagedObjectContext) throws -> MatchEntity? {
        let request = MatchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
}
