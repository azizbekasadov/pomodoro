//
//  AdvancePomodoroPhaseUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 18.04.2026.
//

import Foundation

public struct AdvancePomodoroPhaseUseCase {
    private let clock: Clock
    
    public init(clock: Clock) {
        self.clock = clock
    }
    
    public func execute(
        after activePomodoro: ActivePomodoro,
        configuration: PomodoroConfiguration
    ) -> ActivePomodoro {
        let now = clock.now
        
        switch activePomodoro.phase {
        case .focus:
            let completedFocusCount = activePomodoro.completedFocusCount + 1
            let shouldStartLongBreak =
                completedFocusCount.isMultiple(of: configuration.cyclesBeforeLongBreak)
            
            let nextPhase: PomodoroPhase = shouldStartLongBreak ? .longBreak : .shortBreak
            let duration = shouldStartLongBreak
                ? configuration.longBreakDuration
                : configuration.shortBreakDuration
            
            return ActivePomodoro(
                phase: nextPhase,
                startDate: now,
                endDate: now.addingTimeInterval(duration),
                completedFocusCount: completedFocusCount
            )
            
        case .shortBreak, .longBreak:
            return ActivePomodoro(
                phase: .focus,
                startDate: now,
                endDate: now.addingTimeInterval(configuration.focusDuration),
                completedFocusCount: activePomodoro.completedFocusCount
            )
        }
    }
}
