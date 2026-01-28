//
//  MockTimeProvider.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Foundation
@testable import BerlinClock

struct MockTimeProvider: TimeProviderProtocol {
    var now: Date

    init(hour: Int, minute: Int, second: Int) {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date.now)
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = 0
        now = calendar.date(from: components) ?? Date.now
    }
}
