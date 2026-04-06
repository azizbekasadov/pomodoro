//
//  SharedTestHelpers.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import Foundation
import PomodoroDomain

func anyStartDate() -> Date {
    Date(timeIntervalSince1970: 1_700_000_000)
}

func anyEndDate() -> Date {
    Date(timeIntervalSince1970: 1_700_001_500)
}

func anyBeforeEndDate() -> Date {
    Date(timeIntervalSince1970: 1_700_000_100)
}

func anyFixedClock(now: Date = anyEndDate()) -> Clock {
    FixedClock(now: now)
}
