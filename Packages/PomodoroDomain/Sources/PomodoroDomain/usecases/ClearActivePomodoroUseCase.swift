//
//  ClearActivePomodoroUseCase.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 18.04.2026.
//

import Foundation

public struct ClearActivePomodoroUseCase {
    private let store: ActivePomodoroStore
    
    public init(store: ActivePomodoroStore) {
        self.store = store
    }
    
    public func execute() {
        store.delete()
    }
}
