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
        let components = DateComponents(calendar: calendar, hour: hour, minute: minute, second: second)
        now = calendar.date(from: components)!
    }
}
