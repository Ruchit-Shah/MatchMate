//
//  MatchFilter.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//
 
import Foundation

enum MatchFilter: String, CaseIterable, Identifiable {
    case all
    case accepted
    case declined

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .all: "All"
        case .accepted: "Accepted"
        case .declined: "Declined"
        }
    }

    var systemImage: String {
        switch self {
        case .all: "person.2"
        case .accepted: "checkmark.circle"
        case .declined: "xmark.circle"
        }
    }

    var emptyTitle: String {
        switch self {
        case .all: "No Matches Yet"
        case .accepted: "No Accepted Matches"
        case .declined: "No Declined Matches"
        }
    }

    var emptyMessage: String {
        switch self {
        case .all: "Pull down to refresh and find new matches."
        case .accepted: "Profiles you accept will show up here."
        case .declined: "Profiles you decline will show up here."
        }
    }

    func apply(to profiles: [MatchProfile]) -> [MatchProfile] {
        switch self {
        case .all:
            return profiles
        case .accepted:
            return profiles.filter { $0.status == .accepted }
        case .declined:
            return profiles.filter { $0.status == .declined }
        }
    }
}

