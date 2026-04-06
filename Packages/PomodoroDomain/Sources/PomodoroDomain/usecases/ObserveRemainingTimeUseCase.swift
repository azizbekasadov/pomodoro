//
//  ObserveRemainingTimeUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation
import Combine

public struct ObserveRemainingTimeUseCase {
    private let clock: Clock
    private let calculateRemainingTime: CalculateRemainingTimeUseCase
    
    public init(clock: Clock) {
        self.clock = clock
        self.calculateRemainingTime = CalculateRemainingTimeUseCase()
    }
    
    public func execute(for activePomodoro: ActivePomodoro) -> AnyPublisher<TimeInterval, Never> {
        let initialNow = clock.now
        
        return clock.ticker(every: 1)
            .prepend(initialNow)
            .map { currentDate in
                calculateRemainingTime.execute(for: activePomodoro, now: currentDate)
            }
            .eraseToAnyPublisher()
    }
}
