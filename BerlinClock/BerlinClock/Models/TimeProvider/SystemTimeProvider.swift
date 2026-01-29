//
//  SystemTimeProvider.swift
//  BerlinClock
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Foundation

/// Provides the system's time in the `now` value.
struct SystemTimeProvider: TimeProviderProtocol {
    var now: Date { Date() }
}
