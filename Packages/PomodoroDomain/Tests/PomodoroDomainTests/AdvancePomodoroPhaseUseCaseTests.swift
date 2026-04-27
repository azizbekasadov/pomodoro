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
        assert(
            phase: .focus,
            now: now,
            startDate: now.addingTimeInterval(-25 * 60),
            endDate: now
        ) { result in
                XCTAssertEqual(result.phase, .shortBreak)
                XCTAssertEqual(result.startDate, now)
                XCTAssertEqual(result.endDate, now.addingTimeInterval(5 * 60))
                XCTAssertEqual(result.completedFocusCount, 1)
            }
    }
    
    func test_execute_fromFocus_startsLongBreak_whenLongBreakIsDue() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        
        assert(
            phase: .focus,
            now: now,
            startDate: now.addingTimeInterval(-25 * 60),
            endDate: now,
            completedFocusCount: 3
        ) { result in
            XCTAssertEqual(result.phase, .longBreak)
            XCTAssertEqual(result.startDate, now)
            XCTAssertEqual(result.endDate, now.addingTimeInterval(15 * 60))
            XCTAssertEqual(result.completedFocusCount, 4)
        }
    }
    
    func test_execute_fromBreak_startsFocus_withoutChangingCompletedFocusCount() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        
        assert(
            phase: .shortBreak,
            now: now,
            startDate: now.addingTimeInterval(-5 * 60),
            endDate: now,
            completedFocusCount: 2
        ) { result in
            XCTAssertEqual(result.phase, .focus)
            XCTAssertEqual(result.startDate, now)
            XCTAssertEqual(result.endDate, now.addingTimeInterval(25 * 60))
            XCTAssertEqual(result.completedFocusCount, 2)
        }
    }
    
    func test_execute_fromLongBreak_startsFocus() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        
        assert(
            phase: .longBreak,
            now: now,
            startDate: now.addingTimeInterval(-15 * 60),
            endDate: now,
            completedFocusCount: 4
        ) { result in
            XCTAssertEqual(result.phase, .focus)
            XCTAssertEqual(result.startDate, now)
            XCTAssertEqual(result.endDate, now.addingTimeInterval(25 * 60))
            XCTAssertEqual(result.completedFocusCount, 4)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(now: Date = Date(timeIntervalSince1970: 1_700_000_000)) -> (sut: AdvancePomodoroPhaseUseCase, configuration: PomodoroConfiguration) {
        let clock = FixedClock(now: now)
        let sut = AdvancePomodoroPhaseUseCase(clock: clock)
        let configuration = PomodoroConfiguration(
            focusDuration: 25 * 60,
            shortBreakDuration: 5 * 60,
            longBreakDuration: 15 * 60,
            cyclesBeforeLongBreak: 4
        )
        
        return (sut: sut, configuration: configuration)
    }
    
    private func makeCurrent(
        phase: PomodoroPhase = .longBreak,
        startDate: Date,
        endDate: Date,
        completedFocusCount: Int
    ) -> ActivePomodoro {
        ActivePomodoro(
            phase: phase,
            startDate: startDate,
            endDate: endDate,
            completedFocusCount: completedFocusCount
        )
    }
    
    private func resultAfterExecution(
        _ sut: AdvancePomodoroPhaseUseCase,
        after current: ActivePomodoro,
        with configuration: PomodoroConfiguration
    ) -> ActivePomodoro {
        sut.execute(after: current, configuration: configuration)
    }
    
    private func assert(
        phase: PomodoroPhase,
        now: Date,
        startDate: Date,
        endDate: Date,
        completedFocusCount: Int = 0,
        completion: @escaping (ActivePomodoro) -> Void,
    ) {
        let (sut, configuration) = makeSUT(now: now)
        let current = makeCurrent(
            phase: phase,
            startDate: startDate,
            endDate: endDate, completedFocusCount: completedFocusCount
        )
        
        let result = resultAfterExecution(sut, after: current, with: configuration)
        completion(result)
    }
}
