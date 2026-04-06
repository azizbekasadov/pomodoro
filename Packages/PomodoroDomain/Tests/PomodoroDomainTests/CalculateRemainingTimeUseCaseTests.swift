//
//  CalculateRemainingTimeUseCaseTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation
import PomodoroDomain

final class CalculateRemainingTimeUseCaseTests: XCTestCase {
    
    func test_execute_returnsRemainingTimeWhenPomodoroIsStillRunning() {
        let activePomodoro = makeActivePomodoroItem()

        let result = makeSUT(
            activePomodoro: activePomodoro,
            clockNow: Date(timeIntervalSince1970: 1_700_000_300)
        ).execute(for: activePomodoro)

        XCTAssertEqual(result, 1_200)
    }

    func test_execute_returnsZeroWhenPomodoroIsExpired() {
        let activePomodoro = makeActivePomodoroItem()
        
        let result = makeSUT(
            activePomodoro: activePomodoro,
            clockNow: Date(timeIntervalSince1970: 1_700_002_000)
        ).execute(for: activePomodoro)

        XCTAssertEqual(result, 0)
    }

    func test_execute_returnsZeroWhenCurrentTimeEqualsEndDate() {
        let activePomodoro = makeActivePomodoroItem()
        
        let result = makeSUT(activePomodoro: activePomodoro).execute(for: activePomodoro)
        
        XCTAssertEqual(result, 0)
    }
}

// MARK: - Helpers

extension CalculateRemainingTimeUseCaseTests {
    private func makeSUT(
        activePomodoro: ActivePomodoro,
        clockNow: Date = anyEndDate(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CalculateRemainingTimeUseCase {
        let clock = FixedClock(now: clockNow)
        let sut = CalculateRemainingTimeUseCase(clock: clock)
        
        return sut
    }
    
    private func makeActivePomodoroItem() -> ActivePomodoro {
        ActivePomodoro(
            id: UUID(),
            phase: .focus,
            startDate: anyStartDate(),
            endDate: anyEndDate(),
            completedFocusCount: 0
        )
    }
}
