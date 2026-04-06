//
//  FixedClock.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation
import PomodoroDomain

final class FixedClock: Clock {
    let now: Date
    
    init(now: Date) {
        self.now = now
    }
}
