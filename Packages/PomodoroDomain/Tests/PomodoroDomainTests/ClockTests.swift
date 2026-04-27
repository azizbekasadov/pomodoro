//
//  ClockTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation
import PomodoroDomain

final class ClockTests: XCTestCase {
    func test_startPomodoroUserCase_execute_createsActiveFocusPomodoroUsingCurrentClockTime() {
        // Given
        let now = anyDateNow()
        let (sut, _) = makeSUT(now: now)
        
        // When
        let configuration = anyPomodoroConfiguration(with: 25)
        let result = sut.execute(configuration: configuration)
        
        // Then
        XCTAssertEqual(result.phase, .focus)
        XCTAssertEqual(result.startDate, now)
        XCTAssertEqual(result.endDate, now.addingTimeInterval(25 * 60))
        XCTAssertEqual(result.completedFocusCount, 0)
    }
    
    func test_startPomodoroUserCase_execute_setsEndDateByAddingFocusDurationToCurrentTime() {
        // Given
        let now = anyDateNow()
        let (sut, _) = makeSUT(now: now)
        
        // When
        let configuration = anyPomodoroConfiguration(with: 30)
        let result = sut.execute(configuration: configuration)
        
        // Then
        XCTAssertEqual(result.startDate, now)
        XCTAssertEqual(result.endDate, now.addingTimeInterval(30 * 60))
    }
}

// MARK: - Helpers

extension ClockTests {
    
    private func makeSUT(
        now: Date,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: StartPomodoroUseCase, clock: Clock) {
        let clock = FixedClock(now: anyDateNow())
        let sut = StartPomodoroUseCase(clock: clock)
        
        return (sut, clock)
    }
    
    private func anyDateNow() -> Date {
        Date(timeIntervalSince1970: 1_700_000_000)
    }
    
    private func anyPomodoroConfiguration(with focusDuration: TimeInterval = 25) -> PomodoroConfiguration {
        PomodoroConfiguration(
            focusDuration: focusDuration * 60,
            shortBreakDuration: 5 * 60,
            longBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
    }
}
