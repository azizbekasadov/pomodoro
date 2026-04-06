//
//  ActivePomodoro.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct ActivePomodoro: Equatable, Sendable {
    public let id: UUID
    public let phase: PomodoroPhase
    public let startDate: Date
    public let endDate: Date
    public let completedFocusCount: Int

    public init(
        id: UUID = UUID(),
        phase: PomodoroPhase,
        startDate: Date,
        endDate: Date,
        completedFocusCount: Int
    ) {
        self.id = id
        self.phase = phase
        self.startDate = startDate
        self.endDate = endDate
        self.completedFocusCount = completedFocusCount
    }
}
