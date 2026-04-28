//
//  RestoreActivePomodoroUseCaseTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation
import PomodoroDomain

@MainActor
final class RestoreActivePomodoroUseCaseTests: XCTestCase {
    func test_restoreActivePomodoroUseCase_execute_returnsIdleWhenStoreHasNoActivePomodoro() {
        XCTAssertEqual(makeSUT(activePomodoro: nil).execute(), .idle)
    }

    func test_restoreActivePomodoroUseCase_execute_returnsRunningWhenStoreHasActivePomodoro() {
        let activePomodoro = makeActivePomodoroItem()
        
        let result = makeSUT(
            activePomodoro: activePomodoro,
            clock: anyFixedClock(now: anyBeforeEndDate())
        ).execute()
        
        XCTAssertEqual(result, .running(activePomodoro))
    }
    
    func test_execute_returnsIdleWhenActivePomodoroIsExpired() {
        XCTAssertEqual(makeSUT(activePomodoro: makeActivePomodoroItem()).execute(), .idle)
    }
    
    func test_execute_returnsIdleWhenCurrentTimeIsAfterEndDate() {
        let clock = anyFixedClock(now: Date(timeIntervalSince1970: 1_700_002_000))
        
        let result = makeSUT(activePomodoro: makeActivePomodoroItem(), clock: clock).execute()
        
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
        trackMemoryLeaks(for: store, file: file, line: line)
        return sut
    }
    
    private final class InMemoryActivePomodoroStore: ActivePomodoroStore {
        private let activePomodoro: ActivePomodoro?

        init(activePomodoro: ActivePomodoro?) {
            self.activePomodoro = activePomodoro
        }

        func save(_ activePomodoro: PomodoroDomain.ActivePomodoro) {}
        
        func delete() {}
        
        func load() -> ActivePomodoro? {
            return activePomodoro
        }
    }
}
