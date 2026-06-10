//
//  ProfileImageView.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import SwiftUI

struct ProfileImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeInOut(duration: 0.3))) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure, .empty:
                placeholder
            @unknown default:
                placeholder
            }
        }
        .accessibilityHidden(true)
    }

    private var placeholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.15))
            .overlay {
                Image(systemName: "person.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.secondary)
            }
    }
}

#Preview {
    ProfileImageView(url: nil)
        .frame(width: 100, height: 100)
        .clipShape(Circle())
}
