//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Testing
@testable import BerlinClock

struct ClockViewModelTests {
    let viewModel = ClockViewModel()

    @Test("All lamps are off at init")
    func testInitAllOff() {
        #expect(viewModel.secondsLamp == .off)
        #expect(viewModel.fiveHourRow == [.off, .off, .off, .off])
        #expect(viewModel.oneHourRow == [.off, .off, .off, .off])
        #expect(viewModel.fiveMinuteRow == [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.oneMinuteRow == [.off, .off, .off, .off])
    }
}
