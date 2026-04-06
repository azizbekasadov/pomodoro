//
//  ActivePomodoro.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation
import PomodoroDomain

func makeActivePomodoroItem(
    phase: PomodoroPhase = .focus,
    startDate: Date = anyStartDate(),
    endDate: Date = anyEndDate(),
    completedFocusCount: Int = 0
) -> ActivePomodoro {
    ActivePomodoro(
        id: UUID(),
        phase: phase,
        startDate: startDate,
        endDate: endDate,
        completedFocusCount: completedFocusCount
    )
}
