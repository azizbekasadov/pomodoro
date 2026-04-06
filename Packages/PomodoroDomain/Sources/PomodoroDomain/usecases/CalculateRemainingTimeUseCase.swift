//
//  CalculateRemainingTimeUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct CalculateRemainingTimeUseCase {
    public init() {}
    
    public func execute(for activePomodoro: ActivePomodoro, now: Date) -> TimeInterval {
        max(0, activePomodoro.endDate.timeIntervalSince(now))
    }
}
