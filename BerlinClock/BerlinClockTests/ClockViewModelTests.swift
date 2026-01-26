//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 25/01/2026.
//

import Testing
@testable import BerlinClock

struct ClockViewModelTests {
    @Test("All lamps are off at init")
    func testLampsAreOffAtInit() {
        let viewModel = ClockViewModel()

        #expect(viewModel.secondsLamp == .off)
        #expect(viewModel.fiveHourRow == [.off, .off, .off, .off])
        #expect(viewModel.oneHourRow == [.off, .off, .off, .off])
        #expect(viewModel.fiveMinuteRow == [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.oneMinuteRow == [.off, .off, .off, .off])
    }

    @Test("Lamps are adapted after first tick")
    func testLampsAfterTick() {
        let viewModel = ClockViewModel(timeProvider: MockTimeProvider(hour: 8, minute: 16, second: 0))
        viewModel.tick()

        #expect(viewModel.secondsLamp == .red)
        #expect(viewModel.fiveHourRow == [.red, .off, .off, .off])
        #expect(viewModel.oneHourRow == [.red, .red, .red, .off])
        #expect(viewModel.fiveMinuteRow == [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.oneMinuteRow == [.yellow, .off, .off, .off])
    }
}
