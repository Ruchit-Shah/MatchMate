//
//  MatchProfileMapper.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import CoreData
import Foundation

enum MatchProfileMapper {
    // MARK: - DTO → Domain
    static func map(_ dto: RandomUserDTO) -> MatchProfile? {
        guard let id = dto.login?.uuid, !id.isEmpty else {
            return nil
        }

        let firstName = dto.name?.first ?? ""
        let lastName = dto.name?.last ?? ""

        guard !firstName.isEmpty || !lastName.isEmpty else {
            return nil
        }

        return MatchProfile(
            id: id,
            firstName: firstName,
            lastName: lastName,
            age: dto.dob?.age ?? 0,
            city: dto.location?.city ?? "",
            state: dto.location?.state ?? "",
            country: dto.location?.country ?? "",
            thumbnailURL: url(from: dto.picture?.thumbnail),
            largeImageURL: url(from: dto.picture?.large),
            email: dto.email ?? "",
            phone: dto.phone ?? "",
            status: .none
        )
    }

    static func map(_ dtos: [RandomUserDTO]) -> [MatchProfile] {
        dtos.compactMap(map)
    }

    // MARK: - Entity → Domain

    static func map(_ entity: MatchEntity) -> MatchProfile? {
        guard let id = entity.id, !id.isEmpty else {
            return nil
        }

        let status = MatchStatus(rawValue: entity.status ?? MatchStatus.none.rawValue) ?? .none

        return MatchProfile(
            id: id,
            firstName: entity.firstName ?? "",
            lastName: entity.lastName ?? "",
            age: Int(entity.age),
            city: entity.city ?? "",
            state: entity.state ?? "",
            country: entity.country ?? "",
            thumbnailURL: url(from: entity.thumbnailURL),
            largeImageURL: url(from: entity.largeImageURL),
            email: entity.email ?? "",
            phone: entity.phone ?? "",
            status: status
        )
    }

    // MARK: - Domain → Entity

    @discardableResult
    static func mapToEntity(_ profile: MatchProfile, context: NSManagedObjectContext) -> MatchEntity {
        let entity = MatchEntity(context: context)
        apply(profile, to: entity)
        entity.fetchedAt = Date()
        return entity
    }

    static func apply(_ profile: MatchProfile, to entity: MatchEntity) {
        entity.id = profile.id
        entity.firstName = profile.firstName
        entity.lastName = profile.lastName
        entity.age = Int16(clamping: profile.age)
        entity.city = profile.city
        entity.state = profile.state
        entity.country = profile.country
        entity.thumbnailURL = profile.thumbnailURL?.absoluteString ?? ""
        entity.largeImageURL = profile.largeImageURL?.absoluteString ?? ""
        entity.email = profile.email
        entity.phone = profile.phone
        entity.status = profile.status.rawValue
    }

    // MARK: - Helpers

    private static func url(from string: String?) -> URL? {
        guard let string, !string.isEmpty else {
            return nil
        }
        return URL(string: string)
    }
}
