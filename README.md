# Pomodoro

[![CI](https://github.com/azizbekasadov/pomodoro/actions/workflows/ci.yml/badge.svg)](https://github.com/azizbekasadov/pomodoro/actions/workflows/ci.yml)
[![Swift](https://img.shields.io/badge/swift-5.3-brightgreen)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-brightgreen)](./LICENSE)
[![Contributing](https://img.shields.io/badge/contributing-guide-brightgreen)](./CONTRIBUTING.md)
[![Last Commit](https://img.shields.io/badge/last%20commit-august%202021-orange)](../../commits/main)

A modular, test-driven Pomodoro app for iOS built with:

- SwiftUI
- Combine
- MVVM
- CoreData

This project is designed as an open-source reference app with a strong focus on:

- clean modular architecture
- heavy use of Combine
- UI-agnostic core business logic
- TDD-first development
- local persistence with Core Data
- pagination and search in session history
- local notifications
- Live Activities support

This project is done for hands-on practice only. 

## Goals

This app is being built to explore and demonstrate how to structure a real iOS app with:

- **SwiftUI** for UI
- **MVVM** for presentation
- **Combine** for reactive flows
- **Core Data** for local storage
- **ActivityKit** for Live Activities
- **UserNotifications** for local notifications
- **TDD** for confident, maintainable development

The most important architectural rule is:

> The core business logic must remain independent from SwiftUI, UIKit, Core Data, and other UI/platform frameworks.

---

## Features

### Current / Planned Features

- Start, pause, resume, and stop Pomodoro sessions
- Countdown timer with reactive updates using Combine
- Local notification when a Pomodoro finishes
- Session history stored locally with Core Data
- Session details view
- Search previously completed sessions
- Sessions sorted by date
- Paginated session history:
  - 15 items per page
  - seamless loading when scrolling to the bottom
- Live Activity shown while a Pomodoro is active
- App restoration based on persisted timer state

---

## Architecture

This project follows a **modular architecture** with TDD oriented development.

### Main principles

- **Domain logic is pure Swift**
- **UI depends on abstractions, not infrastructure**
- **Apple-specific frameworks stay in adapters**
- **Combine is used across state observation, search, pagination, and timer flows**
- **TDD drives development from the domain outward**

### Module overview

#### `PomodoroDomain`
Pure business rules and models.

Contains:
- entities
- value objects
- domain policies
- repository/service protocols
- time abstractions

Does **not** import:
- SwiftUI
- UIKit
- CoreData
- ActivityKit
- UserNotifications

This framework is purposefully isolated from any specific UI or infrastructure details framework.

#### `PomodoroApplication`
Application use cases and orchestration.

Contains:
- start/pause/resume/stop use cases
- restore flow
- pagination/search orchestration
- Combine-based application pipelines

#### `PomodoroPersistence`
Infrastructure and data storage.

Contains:
- Core Data stack
- Core Data entities
- repository implementations
- active timer snapshot persistence
- pagination and search queries

#### `PomodoroPlatform`
Platform-specific integrations.

Contains:
- local notifications
- Live Activities
- lifecycle bridges
- concrete clock implementations

#### `PomodoroUI`
SwiftUI presentation layer using MVVM.

Contains:
- screens
- view models
- view data mapping
- navigation

---

## Project Structure

```text
Pomodoro/
├─ Apps/
│  └─ Pomodoro/
├─ Packages/
├─ Docs/
├─ README.md
├─ CONTRIBUTING.md
├─ CODE_OF_CONDUCT.md
└─ License
```

As the project evolves, most reusable code will live under Packages/, while the app target will remain a thin composition layer.

---

## Timer Design

This app does not rely on a continuously running in-process timer when the app is backgrounded or terminated.

Instead, the active Pomodoro is modeled with persisted time state:
- startDate
- endDate
- current phase
- progress metadata

The remaining time is derived from wall-clock time.

This makes the timer restorable and much more robust than relying on a long-running process.

---

## Why Combine?

Combine is used widely in this project, including:
- countdown observation
- reactive view model state
- debounced search
- pagination triggers
- lifecycle event handling
- repository pipelines
- restoration flows

The goal is to use Combine not just for convenience, but as a core architectural tool.

---

## Getting Started

Requirements
- Xcode 16+
- iOS 17+
- Swift 5.9+

**Run the project**
- Clone the repository
- Open the Xcode project
- Build and run the app target

```git
git clone https://github.com/azizbekasadov/pomodoro
cd Pomodoro
open Apps/Pomodoro/Pomodoro.xcodeproj
```

## Running Tests

Run tests from CLI:

```bash
xcodebuild test \
  -project Apps/Pomodoro/Pomodoro.xcodeproj \
  -scheme Pomodoro \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```
