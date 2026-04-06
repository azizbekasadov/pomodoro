//
//  ClockTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation
import PomodoroDomainc

public struct StartPomodoroUseCase {
    private let clock: Clock

    public init(clock: Clock) {
        self.clock = clock
    }

    public func execute(configuration: PomodoroConfiguration) -> ActivePomodoro {
        let startDate = clock.now
        let endDate = startDate.addingTimeInterval(configuration.focusDuration)

        return ActivePomodoro(
            id: UUID(),
            phase: .focus,
            startDate: startDate,
            endDate: endDate,
            completedFocusCount: 0
        )
    }
}

final class ClockTests: XCTestCase {
    
    func test_startPomodoroUserCase_execute_createsActiveFocusPomodoroUsingCurrentClockTime() {
        // Given
        let now = anyDateNow()
        let (sut, _) = makeSUT(now: now)
        
        // When
        let configuration = anyPomodoroConfiguration()
        let result = sut.execute(configuration: configuration)
        
        // Then
        XCTAssertEqual(result.phase, .focus)
        XCTAssertEqual(result.startDate, now)
        XCTAssertEqual(result.endDate, now.addingTimeInterval(25 * 60))
        XCTAssertEqual(result.completedFocusCount, 0)
    }
}

// MARK: - Helpers

extension ClockTests {
    
    private func makeSUT(
        now: Date,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: StartPomodoroUseCase, clock: Clock){
        let now = anyDateNow()
        let clock = FixedClock(now: now)
        let sut = StartPomodoroUseCase(clock: clock)
        
        return (sut, clock)
    }
    
    private final class FixedClock: Clock {
        let now: Date
        
        init(now: Date) {
            self.now = now
        }
    }
    
    private func anyDateNow() -> Date {
        Date(timeIntervalSince1970: 1_700_000_000)
    }
    
    private func anyPomodoroConfiguration() -> PomodoroConfiguration {
        PomodoroConfiguration(
            focusDuration: 25 * 60,
            shortBreakDuration: 5 * 60,
            loongBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
    }
}
