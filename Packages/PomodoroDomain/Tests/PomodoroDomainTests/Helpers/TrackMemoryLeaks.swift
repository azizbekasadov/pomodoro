//
//  TrackMemoryLeaks.swift
//  PomodoroDomain
//
//  Created by Azizbek Asadov on 06.04.2026.
//

import XCTest
import Foundation

@MainActor
public extension XCTestCase {
    func trackMemoryLeaks(
        for entity: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak entity] in
            XCTAssertNil(entity, "\(String(describing: entity)) must have been deallocated", file: file, line: line)
        }
    }
}
