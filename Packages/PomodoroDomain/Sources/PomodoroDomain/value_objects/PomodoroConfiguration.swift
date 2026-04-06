//
//  PomodoroConfiguration.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation

public struct PomodoroConfiguration: Equatable, Sendable {
    public let focusDuration: TimeInterval
    public let shortBreakDuration: TimeInterval
    public let loongBreakDuration: TimeInterval
    public let cyclesBeforeLongBreak: Int
    
    public init(focusDuration: TimeInterval, shortBreakDuration: TimeInterval, loongBreakDuration: TimeInterval, cyclesBeforeLongBreak: Int) {
        self.focusDuration = focusDuration
        self.shortBreakDuration = shortBreakDuration
        self.loongBreakDuration = loongBreakDuration
        self.cyclesBeforeLongBreak = cyclesBeforeLongBreak
    }
}
