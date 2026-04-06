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

        let result = makeSUT(activePomodoro: activePomodoro)
            .execute(
                for: activePomodoro,
                now: anyStartDate().addingTimeInterval(300)
            )

        XCTAssertEqual(result, 1_200)
    }

    func test_execute_returnsZeroWhenPomodoroIsExpired() {
        let activePomodoro = makeActivePomodoroItem()
        
        let result = makeSUT(
            activePomodoro: activePomodoro
        ).execute(
            for: activePomodoro,
            now: anyStartDate().addingTimeInterval(2_000)
        )

        XCTAssertEqual(result, 0)
    }

    func test_execute_returnsZeroWhenCurrentTimeEqualsEndDate() {
        let activePomodoro = makeActivePomodoroItem()
        
        let result = makeSUT(activePomodoro: activePomodoro).execute(
            for: activePomodoro,
            now: .now
        )
        
        XCTAssertEqual(result, 0)
    }
}

// MARK: - Helpers

extension CalculateRemainingTimeUseCaseTests {
    private func makeSUT(
        activePomodoro: ActivePomodoro,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CalculateRemainingTimeUseCase {
        let sut = CalculateRemainingTimeUseCase()
        return sut
    }
}
