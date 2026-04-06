//
//  FixedClock.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Combine
import Foundation
import PomodoroDomain

final class FixedClock: Clock {
    let now: Date
    
    init(now: Date) {
        self.now = now
    }
    
    func ticker(every interval: TimeInterval) -> AnyPublisher<Date, Never> {
        Empty<Date, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
}
