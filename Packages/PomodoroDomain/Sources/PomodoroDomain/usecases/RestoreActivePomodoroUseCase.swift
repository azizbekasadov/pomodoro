//
//  RestoreActivePomodoroUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct RestoreActivePomodoroUseCase {
    private let store: ActivePomodoroStore
    private let clock: PomodoroDomain.Clock

    public init(store: ActivePomodoroStore, clock: PomodoroDomain.Clock) {
        self.store = store
        self.clock = clock
    }

    public func execute() -> PomodoroState {
        guard let activePomodoro = store.load() else {
            return .idle
        }
        
        guard activePomodoro.endDate > clock.now else {
            return .idle
        }

        return .running(activePomodoro)
    }
}
