//
//  StartPomodoroUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct StartPomodoroUseCase {
    private let clock: PomodoroDomain.Clock

    public init(clock: PomodoroDomain.Clock) {
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
