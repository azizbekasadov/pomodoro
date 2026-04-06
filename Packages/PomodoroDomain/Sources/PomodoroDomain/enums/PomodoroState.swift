//
//  PomodoroState.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public enum PomodoroState: Equatable, Sendable {
    case idle
    case running(ActivePomodoro)
}
