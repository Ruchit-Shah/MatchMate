# MatchMate – Matrimonial Card Interface (iOS)

## Overview

MatchMate is an iOS application built using SwiftUI that simulates a matrimonial matchmaking experience similar to Shaadi.com.

The application fetches user profiles from the Random User API and displays them as profile cards. Users can Accept or Decline profiles, and their decisions are stored locally using Core Data to support offline access and persistence.

---

## Features

### Profile Management
- Fetch profiles from Random User API
- Display matrimonial-style profile cards
- Show profile image, name, age, and location
- Pull-to-refresh support

### Match Actions
- Accept Profile
- Decline Profile
- Persist decisions locally
- Display Accepted / Declined status

### Offline Support
- Cache profiles using Core Data
- Display cached profiles when offline
- Accept/Decline actions continue to work without internet
- Persist user decisions across app launches

### User Experience
- SwiftUI-based modern interface
- Loading state support
- Error handling with retry mechanism
- Offline status banner
- Clean and responsive card design

---

## Architecture

The project follows MVVM (Model-View-ViewModel) architecture combined with the Repository Pattern to ensure maintainability, testability, and separation of concerns.

### Folder Structure

text MatchMate │ ├── App ├── Core │   ├── Network │   ├── Persistence │   └── Utilities │ ├── Domain │   ├── Models │   └── Repository │ ├── Data │   ├── DTO │   └── Repository │ ├── Presentation │   └── Home │       ├── View │       ├── ViewModel │       └── Components │ └── Resources 

---

## Technologies Used

### UI Framework
- SwiftUI

### Networking
- URLSession
- Async/Await

### Data Persistence
- Core Data

### Image Loading
- SDWebImageSwiftUI

### Reactive Programming
- Combine

### Network Monitoring
- Network Framework (NWPathMonitor)

### Testing
- XCTest

---

## API

The application uses the Random User API:

text https://randomuser.me/api/?results=10 

This endpoint returns 10 user profiles that are displayed as matrimonial match cards.

---

## Core Data

The application stores profile information locally using Core Data.

### Entity: ProfileEntity

Attributes:

- id
- firstName
- lastName
- age
- city
- state
- country
- imageURL
- status
- createdAt
- updatedAt

A unique constraint is applied on:

text id 

to prevent duplicate profile entries.

---

## Offline Mode

The application follows an offline-first approach.

### Online

text API → Core Data → UI 

### Offline

text Core Data → UI 

When internet connectivity is unavailable:

- Cached profiles are displayed
- Accept/Decline actions remain available
- Decisions are stored locally

### Sync Note

The Random User API is a read-only API and does not provide endpoints for updating profile status on a server.

Therefore, Accept/Decline decisions are stored locally and retained across launches. The project structure is designed to support future backend synchronization if a writable API becomes available.

---

## Error Handling

The application handles:

- Invalid URLs
- Invalid server responses
- JSON decoding failures
- Network connectivity issues
- Offline state handling
- Core Data persistence failures

Users are provided with meaningful error messages and retry options.

---

## Unit Testing

Unit tests cover:

- Successful profile loading
- Cached profile loading
- Offline mode handling
- Accept profile status update
- Decline profile status update

---

## Requirements

### Development Environment

- Xcode 16+
- Swift 6+
- iOS 18+

---

## How to Run

1. Clone the repository.

bash git clone <repository-url> 

2. Open the project in Xcode.

bash MatchMate.xcodeproj 

3. Select an iOS Simulator.

4. Build and Run.

bash ⌘ + R 

---

## Assignment Requirements Coverage

| Requirement | Status |
|------------|---------|
| API Integration | ✅ |
| SwiftUI Match Cards | ✅ |
| Accept / Decline | ✅ |
| Core Data Persistence | ✅ |
| Offline Support | ✅ |
| MVVM Architecture | ✅ |
| Repository Pattern | ✅ |
| Error Handling | ✅ |
| Image Loading | ✅ |
| Unit Testing | ✅ |
| Clean UI | ✅ |

---

## Future Improvements

- Profile filtering
- Search functionality
- Favorites support
- Pagination
- Backend synchronization
- Profile detail screen
- Match recommendations

---

## Author

Ruchit Shah

Senior iOS Developer

- Swift
- SwiftUI
- UIKit
- Combine
- Core Data
- Clean Architecture
- MVVM
- Mobile Application Development
