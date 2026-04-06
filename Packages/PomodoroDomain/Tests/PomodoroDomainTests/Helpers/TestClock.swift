//
//  TestClock.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Combine
import Foundation
import PomodoroDomain

final class TestClock: PomodoroDomain.Clock {
    private let subject = PassthroughSubject<Date, Never>()
    
    var now: Date
    
    init(now: Date) {
        self.now = now
    }

    func ticker(every interval: TimeInterval) -> AnyPublisher<Date, Never> {
        subject.eraseToAnyPublisher()
    }

    func send(_ date: Date) {
        now = date
        subject.send(date)
    }
}
