//
//  SaveActivePomodoroUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 18.04.2026.
//

import Foundation

public struct SaveActivePomodoroUseCase {
    private let store: ActivePomodoroStore
    
    public init(store: ActivePomodoroStore) {
        self.store = store
    }
    
    public func execute(_ activePomodoro: ActivePomodoro) {
        store.save(activePomodoro)
    }
}
