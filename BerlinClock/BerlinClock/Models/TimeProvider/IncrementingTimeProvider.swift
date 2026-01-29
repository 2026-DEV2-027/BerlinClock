//
//  IncrementingTimeProvider.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Foundation

/// At initialization the `now` value is the system's time. On each access, `now` is incremented by 1 second regardless of the system's time.
///
/// This is useful for mocking the speed of time passing.
class IncrementingTimeProvider: TimeProviderProtocol {
    private var current = Date()

    var now: Date {
        current = current.addingTimeInterval(1)
        return current
    }
}
