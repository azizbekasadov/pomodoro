//
//  RestoreActivePomodoroUseCaseTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation
import PomodoroDomain

final class RestoreActivePomodoroUseCaseTests: XCTestCase {
    func test_restoreActivePomodoroUseCase_execute_returnsIdleWhenStoreHasNoActivePomodoro() {
        XCTAssertEqual(makeSUT(activePomodoro: nil).execute(), .idle)
    }

    func test_restoreActivePomodoroUseCase_execute_returnsRunningWhenStoreHasActivePomodoro() {
        let activePomodoro = ActivePomodoro(
            id: UUID(),
            phase: .focus,
            startDate: anyStartDate(),
            endDate: anyEndDate(),
            completedFocusCount: 0
        )
        
        let result = makeSUT(
            activePomodoro: activePomodoro,
            clock: anyFixedClock(now: anyBeforeEndDate())
        ).execute()
        
        XCTAssertEqual(result, .running(activePomodoro))
    }
    
    func test_execute_returnsIdleWhenActivePomodoroIsExpired() {
        let activePomodoro = ActivePomodoro(
            id: UUID(),
            phase: .focus,
            startDate: anyStartDate(),
            endDate: anyEndDate(),
            completedFocusCount: 0
        )
        
        XCTAssertEqual(makeSUT(activePomodoro: activePomodoro).execute(), .idle)
    }
    
    func test_execute_returnsIdleWhenCurrentTimeIsAfterEndDate() {
        let activePomodoro = ActivePomodoro(
            id: UUID(),
            phase: .focus,
            startDate: anyStartDate(),
            endDate: anyEndDate(),
            completedFocusCount: 0
        )
        let clock = anyFixedClock(now: Date(timeIntervalSince1970: 1_700_002_000))
        
        let result = makeSUT(activePomodoro: activePomodoro, clock: clock).execute()
        
        XCTAssertEqual(result, .idle)
    }
}

extension RestoreActivePomodoroUseCaseTests {
    
    private func makeSUT(
        activePomodoro: ActivePomodoro?,
        clock: Clock = anyFixedClock(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> RestoreActivePomodoroUseCase {
        let store = InMemoryActivePomodoroStore(activePomodoro: activePomodoro)
        let sut = RestoreActivePomodoroUseCase(store: store, clock: clock)
        
        return sut
    }
    
    private final class InMemoryActivePomodoroStore: ActivePomodoroStore {
        private let activePomodoro: ActivePomodoro?

        init(activePomodoro: ActivePomodoro?) {
            self.activePomodoro = activePomodoro
        }

        func load() -> ActivePomodoro? {
            return activePomodoro
        }
    }
}

private func anyStartDate() -> Date {
    Date(timeIntervalSince1970: 1_700_000_000)
}

private func anyEndDate() -> Date {
    Date(timeIntervalSince1970: 1_700_001_500)
}

private func anyBeforeEndDate() -> Date {
    Date(timeIntervalSince1970: 1_700_000_100)
}

private func anyFixedClock(now: Date = anyEndDate()) -> Clock {
    FixedClock(now: now)
}
