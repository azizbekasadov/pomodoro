//
//  ObserveRemainingTimeUseCaseTests.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Combine
import Foundation
import PomodoroDomain

@MainActor
final class ObserveRemainingTimeUseCaseTests: XCTestCase {
    nonisolated private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        
        cancellables.forEach { $0.cancel() }
        cancellables = []
    }
    
    func test_execute_emitsCurrentRemainingTimeImmediatelyOnSubscription() {
        let startDate = anyStartDate()
        let activePomodoro = makeActivePomodoroItem(
            startDate: startDate,
            endDate: startDate.addingTimeInterval(1_500)
        )
        
        let (sut, _) = makeSUT(clockNow: startDate.addingTimeInterval(10))
        
        let receivedValues = collectReceivedValues(
            sut: sut,
            for: activePomodoro,
            perform: {}
        )

        XCTAssertEqual(receivedValues, [1_490])
    }
    
    func test_execute_emitsRemainingTimeForEachTick() {
        let startDate = anyStartDate()
        
        let activePomodoro = makeActivePomodoroItem(
            startDate: startDate,
            endDate: startDate.addingTimeInterval(1_500),
        )

        let (sut, clock) = makeSUT()

        let receivedValues = collectReceivedValues(
            sut: sut,
            for: activePomodoro
        ) {
            clock.send(startDate.addingTimeInterval(1))
            clock.send(startDate.addingTimeInterval(2))
        }

        XCTAssertEqual(receivedValues, [1_500, 1_499, 1_498])
    }

    func test_execute_emitsZeroWhenPomodoroExpires() {
        let startDate = anyStartDate()
        let activePomodoro = makeActivePomodoroItem(
            startDate: startDate,
            endDate: startDate.addingTimeInterval(2)
        )

        let (sut, clock) = makeSUT()
        let receivedValues = collectReceivedValues(
            sut: sut,
            for: activePomodoro
        ) {
            clock.send(startDate.addingTimeInterval(1))
            clock.send(startDate.addingTimeInterval(2))
            clock.send(startDate.addingTimeInterval(3))
        }
        
        XCTAssertEqual(receivedValues, [2, 1, 0, 0])
    }
}

// MARK: - Helpers

extension ObserveRemainingTimeUseCaseTests {
    private func makeSUT(
        clockNow: Date = anyStartDate(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: ObserveRemainingTimeUseCase, clock: TestClock) {
        let clock = TestClock(now: clockNow)
        let sut = ObserveRemainingTimeUseCase(clock: clock)
        
        return (sut, clock)
    }
    
    private func collectReceivedValues(
        sut: ObserveRemainingTimeUseCase,
        for activePomodoro: ActivePomodoro,
        perform actions: () -> Void
    ) -> [TimeInterval] {
        var receivedValues: [TimeInterval] = []

        sut.execute(for: activePomodoro)
            .sink { [weak self] value in
                guard self != nil else { return }
                
                receivedValues.append(value)
            }
            .store(in: &cancellables)
    
        actions()
        
        return receivedValues
    }
}
