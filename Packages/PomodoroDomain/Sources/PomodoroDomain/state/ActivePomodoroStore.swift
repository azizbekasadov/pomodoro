//
//  ActivePomodoroStore.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

public protocol ActivePomodoroStore {
    func load() -> ActivePomodoro?
    func save(_ activePomodoro: ActivePomodoro)
    func delete()
}
