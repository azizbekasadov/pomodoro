//
//  AdvancePomodoroPhaseUseCaseTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 18.04.2026.
//

import XCTest
import Foundation
import PomodoroDomain

final class AdvancePomodoroPhaseUseCaseTests: XCTestCase {
    func test_execute_fromFocus_startsShortBreak_whenLongBreakIsNotDue() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let clock = FixedClock(now: now)
        let sut = AdvancePomodoroPhaseUseCase(clock: clock)
        
        let configuration = PomodoroConfiguration(
            focusDuration: 25 * 60,
            shortBreakDuration: 5 * 60,
            longBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
        
        let current = ActivePomodoro(
            phase: .focus,
            startDate: now.addingTimeInterval(-25 * 60),
            endDate: now,
            completedFocusCount: 0
        )
        
        let next = sut.execute(after: current, configuration: configuration)
        
        XCTAssertEqual(next.phase, PomodoroPhase.shortBreak)
        XCTAssertEqual(next.startDate, now)
        XCTAssertEqual(next.endDate, now.addingTimeInterval(5 * 60))
        XCTAssertEqual(next.completedFocusCount, 1)
    }
    
    func test_execute_fromFocus_startsLongBreak_whenLongBreakIsDue() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let clock = FixedClock(now: now)
        let sut = AdvancePomodoroPhaseUseCase(clock: clock)
        
        let configuration = PomodoroConfiguration(
            focusDuration: 25 * 60,
            shortBreakDuration: 5 * 60,
            longBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
        
        let current = ActivePomodoro(
            phase: .focus,
            startDate: now.addingTimeInterval(-25 * 60),
            endDate: now,
            completedFocusCount: 3
        )
        
        let next = sut.execute(after: current, configuration: configuration)
        
        XCTAssertEqual(next.phase, .longBreak)
        XCTAssertEqual(next.startDate, now)
        XCTAssertEqual(next.endDate, now.addingTimeInterval(15 * 60))
        XCTAssertEqual(next.completedFocusCount, 4)
    }
    
    func test_execute_fromBreak_startsFocus_withoutChangingCompletedFocusCount() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let clock = FixedClock(now: now)
        let sut = AdvancePomodoroPhaseUseCase(clock: clock)
        
        let configuration = PomodoroConfiguration(
            focusDuration: 25 * 60,
            shortBreakDuration: 5 * 60,
            longBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
        
        let current = ActivePomodoro(
            phase: .shortBreak,
            startDate: now.addingTimeInterval(-5 * 60),
            endDate: now,
            completedFocusCount: 2
        )
        
        let next = sut.execute(after: current, configuration: configuration)
        
        XCTAssertEqual(next.phase, .focus)
        XCTAssertEqual(next.startDate, now)
        XCTAssertEqual(next.endDate, now.addingTimeInterval(25 * 60))
        XCTAssertEqual(next.completedFocusCount, 2)
    }
}
