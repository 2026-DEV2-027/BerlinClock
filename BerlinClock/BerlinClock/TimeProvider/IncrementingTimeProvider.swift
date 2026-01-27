//
//  IncrementingTimeProvider.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 27/01/2026.
//

import Foundation

class IncrementingTimeProvider: TimeProviderProtocol {
    private var current = Date()

    var now: Date {
        current = current.addingTimeInterval(1)
        return current
    }
}
