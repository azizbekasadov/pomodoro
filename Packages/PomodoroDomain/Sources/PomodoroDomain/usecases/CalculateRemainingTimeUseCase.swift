//
//  CalculateRemainingTimeUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct CalculateRemainingTimeUseCase {
    private let clock: Clock

    public init(clock: Clock) {
        self.clock = clock
    }

    public func execute(for activePomodoro: ActivePomodoro) -> TimeInterval {
        max(0, activePomodoro.endDate.timeIntervalSince(clock.now))
    }
}
