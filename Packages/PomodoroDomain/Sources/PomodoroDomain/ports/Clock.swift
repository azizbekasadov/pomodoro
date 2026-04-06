//
//  Clock.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Combine
import Foundation

public protocol Clock {
    var now: Date { get }
    
    func ticker(every interval: TimeInterval) -> AnyPublisher<Date, Never>
}
