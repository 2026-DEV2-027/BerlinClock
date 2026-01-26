//
//  ClockEngineTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-027 on 26/01/2026.
//

import Testing
@testable import BerlinClock

struct ClockEngineTests {
    let clockEngine = ClockEngine()

    @Test("Seconds lamp lights up when seconds are even and turns off when seconds are odd")
    func testSecondsLamp() async throws {
        #expect(clockEngine.computeSecondsLamp(seconds: 0) == .red)
        #expect(clockEngine.computeSecondsLamp(seconds: 1) == .off)
        #expect(clockEngine.computeSecondsLamp(seconds: 2) == .red)
        #expect(clockEngine.computeSecondsLamp(seconds: 59) == .off)
    }
}
